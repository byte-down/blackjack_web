import '../models/hand.dart';
import '../models/player_hand.dart';
import '../models/shoe.dart';

import '../strategies/strategy.dart';

class BlackjackGame {
  final Shoe shoe;

  final Strategy strategy;

  final bool hitSoft17;

  BlackjackGame({
    required this.shoe,
    required this.strategy,
    this.hitSoft17 = true,
  });

  double playHand() {
    final dealer = Hand();

    final List<PlayerHand> playerHands = [
      PlayerHand(bet: 1),
    ];

    // Initial Deal

    playerHands.first.addCard(shoe.deal());
    dealer.addCard(shoe.deal());

    playerHands.first.addCard(shoe.deal());
    dealer.addCard(shoe.deal());

    // Dealer Blackjack Check

    if (dealer.isBlackjack) {
      double loss = 0;

      for (final hand in playerHands) {
        if (hand.isBlackjack) {
          continue;
        }

        loss -= hand.bet;
      }

      return loss;
    }

    // Player Blackjack Check

    if (playerHands.first.isBlackjack) {
      return 1.5 * playerHands.first.bet;
    }

    // Process Each Player Hand

    for (int i = 0; i < playerHands.length; i++) {
      final hand = playerHands[i];

      while (!hand.finished) {
        final action = strategy.decide(
          playerHand: hand,
          dealerUpcard: dealer.cards.first,
          canDouble: hand.cards.length == 2,
          canSplit: hand.canSplit,
        );

        // STAND

        if (action == 'stand') {
          hand.finished = true;
        }

        // HIT

        else if (action == 'hit') {
          hand.addCard(shoe.deal());

          if (hand.isBust) {
            hand.finished = true;
          }
        }

        // DOUBLE

        else if (action == 'double') {
          hand.doubleDown();

          hand.addCard(shoe.deal());

          hand.finished = true;
        }

        // SPLIT

        else if (action == 'split') {
          // Prevent splitting unless exactly 2 cards
          if (!hand.canSplit) {
            hand.finished = true;
            continue;
          }

          final splitCard = hand.cards.removeLast();

          final newHand = PlayerHand(
            bet: hand.bet,
          );

          newHand.addCard(splitCard);

          // One new card to each hand
          hand.addCard(shoe.deal());
          newHand.addCard(shoe.deal());

          // Add new hand to queue
          playerHands.add(newHand);
        }

        // Fallback Safety

        else {
          hand.finished = true;
        }
      }
    }

    // Dealer Turn

    while (true) {
      final total = dealer.value;

      if (total < 17) {
        dealer.addCard(shoe.deal());
      }

      else if (
          total == 17 &&
          dealer.isSoft &&
          hitSoft17) {
        dealer.addCard(shoe.deal());
      }

      else {
        break;
      }
    }

    // Final Payouts

    double totalProfit = 0;

    for (final hand in playerHands) {
      // Bust

      if (hand.isBust) {
        totalProfit -= hand.bet;
        continue;
      }

      // Dealer Bust

      if (dealer.isBust) {
        totalProfit += hand.bet;
        continue;
      }

      // Compare Totals

      if (hand.value > dealer.value) {
        totalProfit += hand.bet;
      }

      else if (hand.value < dealer.value) {
        totalProfit -= hand.bet;
      }

      // Push = no change
    }

    return totalProfit;
  }
}