import 'dart:async';

import 'package:flutter/material.dart';

import '../engine/blackjack_game.dart';

import '../models/hand.dart';
import '../models/player_hand.dart';
import '../models/shoe.dart';
import '../models/dealer_animation_state.dart';

import '../strategies/basic_strategy.dart';

class GameController extends ChangeNotifier {
  late Shoe shoe;

  late BlackjackGame game;

  List<PlayerHand> playerHands = [];

  Hand dealerHand = Hand();

  DealerAnimationState dealerAnimationState = DealerAnimationState.idle;

  String status = 'Press Deal';

  double bankroll = 100;

  double currentBet = 10;

  final TextEditingController betController = TextEditingController(
    text: '10',
  );

  int handsPlayed = 0;

  bool isPlaying = false;

  bool dealerHoleCardRevealed = false;

  bool playerTurn = false;

  bool handOver = false;

  int currentHandIndex = 0;

  GameController() {
    shoe = Shoe(decks: 6);

    game = BlackjackGame(
      shoe: shoe,
      strategy: BasicStrategy(),
      hitSoft17: true,
    );
  }

  void setDealerState(
    DealerAnimationState state,
  ) {
    dealerAnimationState = state;
    notifyListeners();
  }

  PlayerHand get currentHand {
    if (playerHands.isEmpty) {
      return PlayerHand(
        bet: currentBet,
      );
    }

    if (currentHandIndex >= playerHands.length) {
      currentHandIndex = playerHands.length - 1;
    }

    if (currentHandIndex < 0) {
      currentHandIndex = 0;
    }

    return playerHands[currentHandIndex];
  }

  Future<void> startHand() async {
    if (isPlaying) return;

    isPlaying = true;

    handOver = false;

    playerTurn = false;

    currentHandIndex = 0;

    notifyListeners();

    // Reset table

    playerHands = [
      PlayerHand(bet: currentBet),
    ];

    bankroll -= currentBet;

    dealerHand = Hand();
    dealerHoleCardRevealed = false;

    status = 'Dealing cards...';

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    setDealerState(
      DealerAnimationState.dealPlayer,
    );
    // Initial Deal

    playerHands.first.addCard(shoe.deal());

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    dealerHand.addCard(shoe.deal());

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    playerHands.first.addCard(shoe.deal());

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    dealerHand.addCard(shoe.deal());

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    setDealerState(
      DealerAnimationState.idle,
    );
    // Blackjack checks

    // Dealer Peek Logic

    final dealerUpcard = dealerHand.cards.first.value;

    bool dealerChecksBlackjack = dealerUpcard == 10 || dealerUpcard == 11;

    if (dealerChecksBlackjack && dealerHand.isBlackjack) {
      dealerHoleCardRevealed = true;

      playerTurn = false;

      isPlaying = false;

      handOver = true;

      if (playerHands.first.isBlackjack) {
        bankroll += playerHands.first.bet;
        status = 'Push - Both Blackjack';
      } else {
        status = 'Dealer Blackjack';
      }

      handsPlayed++;

      notifyListeners();

      return;
    }

    if (playerHands.first.isBlackjack) {
      bankroll += 2.5 * playerHands.first.bet;

      status = 'Blackjack!';

      playerTurn = false;

      isPlaying = false;

      handOver = true;

      handsPlayed++;

      notifyListeners();

      return;
    }

    // Start player turn

    playerTurn = true;

    status = 'Your move';

    notifyListeners();
  }

  Future<void> hit() async {
    if (!playerTurn) return;

    setDealerState(
      DealerAnimationState.dealPlayer,
    );

    currentHand.addCard(shoe.deal());

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    setDealerState(
      DealerAnimationState.idle,
    );

    if (currentHand.isBust) {
      currentHand.finished = true;

      status = 'Bust!';

      notifyListeners();

      await Future.delayed(
        const Duration(milliseconds: 700),
      );

      await nextHand();
      return;
    }

    if (currentHand.value == 21) {
      currentHand.finished = true;

      status = 'Stand';

      notifyListeners();

      await Future.delayed(
        const Duration(milliseconds: 700),
      );

      await nextHand();
    }
  }

  Future<void> stand() async {
    if (!playerTurn) return;

    currentHand.finished = true;

    status = 'Stand';

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    await nextHand();
  }

  Future<void> doubleDown() async {
    if (!playerTurn) return;

    if (currentHand.cards.length != 2) {
      return;
    }

    setDealerState(
      DealerAnimationState.dealPlayer,
    );

    final additionalBet = currentHand.bet;
    currentHand.doubleDown();
    bankroll -= additionalBet;

    currentHand.addCard(shoe.deal());

    status = 'Double Down';

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    setDealerState(
      DealerAnimationState.idle,
    );

    currentHand.finished = true;

    if (currentHand.isBust) {
      status = 'Bust after double';
    }

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    await nextHand();
  }

  Future<void> split() async {
    if (!playerTurn) return;

    if (!currentHand.canSplit) {
      return;
    }

    final splitCard = currentHand.cards.removeLast();

    final newHand = PlayerHand(
      bet: currentHand.bet,
    );

    newHand.addCard(splitCard);

    bankroll -= currentHand.bet;

    currentHand.addCard(shoe.deal());

    newHand.addCard(shoe.deal());

    playerHands.add(newHand);

    status = 'Split';

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (currentHand.value == 21) {
      currentHand.finished = true;
    }

    if (newHand.value == 21) {
      newHand.finished = true;
    }

    if (currentHand.finished) {
      await nextHand();
      return;
    }

    status = 'Your move';

    notifyListeners();
  }

  Future<void> nextHand() async {
    while (true) {
      currentHandIndex++;

      if (currentHandIndex >= playerHands.length) {
        break;
      }

      if (!playerHands[currentHandIndex].finished) {
        status = 'Playing Hand ${currentHandIndex + 1}';

        notifyListeners();

        return;
      }
    }

    // All hands complete

    playerTurn = false;

    notifyListeners();

    await dealerTurn();
  }

  Future<void> dealerTurn() async {
    status = 'Dealer turn';

    dealerHoleCardRevealed = true;

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    while (true) {
      final total = dealerHand.value;

      if (total < 17) {
        dealerHand.addCard(shoe.deal());

        notifyListeners();

        await Future.delayed(
          const Duration(milliseconds: 600),
        );
      } else if (total == 17 && dealerHand.isSoft && game.hitSoft17) {
        dealerHand.addCard(shoe.deal());

        notifyListeners();

        await Future.delayed(
          const Duration(milliseconds: 600),
        );
      } else {
        break;
      }
    }

    settleBets();
  }

  void settleBets() {
    double totalPayout = 0;

    for (final hand in playerHands) {
      if (hand.isBust) {
        continue;
      }

      if (dealerHand.isBust) {
        totalPayout += hand.bet * 2;
        continue;
      }

      if (hand.value > dealerHand.value) {
        totalPayout += hand.bet * 2;
      } else if (hand.value == dealerHand.value) {
        totalPayout += hand.bet;
      }
      // Loss = no payout
    }

    final totalWagered = playerHands.fold(0.0, (sum, hand) => sum + hand.bet);
    final totalProfit = totalPayout - totalWagered;

    bankroll += totalPayout;

    handsPlayed++;

    handOver = true;

    isPlaying = false;

    if (totalProfit > 0) {
      status = 'Player Wins';
    } else if (totalProfit < 0) {
      status = 'Dealer Wins';
    } else {
      status = 'Push';
    }

    notifyListeners();
  }

  String get dealerDisplayValue {
    if (!dealerHoleCardRevealed && dealerHand.cards.length >= 2) {
      final upcard = dealerHand.cards.first;

      return upcard.value.toString();
    }

    return dealerHand.displayValue;
  }

  double get totalWager {
    if (!isPlaying) {
      return currentBet;
    }

    return playerHands.fold(0.0, (sum, hand) => sum + hand.bet);
  }

  void updateBet(String value) {
    final parsed = double.tryParse(value);

    if (parsed == null) return;

    currentBet = parsed.clamp(1, 500);

    betController.text = currentBet.toInt().toString();

    betController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: betController.text.length,
      ),
    );

    notifyListeners();
  }

  void halveBet() {
    currentBet = (currentBet * 0.5).clamp(1, 500);

    currentBet = currentBet.roundToDouble();

    betController.text = currentBet.toInt().toString();

    notifyListeners();
  }

  void doubleBet() {
    currentBet = (currentBet * 2).clamp(1, 500);

    currentBet = currentBet.roundToDouble();

    betController.text = currentBet.toInt().toString();

    notifyListeners();
  }
}
