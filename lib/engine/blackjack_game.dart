import '../models/hand.dart';
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

    final player = Hand();
    final dealer = Hand();

    player.addCard(shoe.deal());
    dealer.addCard(shoe.deal());

    player.addCard(shoe.deal());
    dealer.addCard(shoe.deal());

    if (player.isBlackjack) {

      if (dealer.isBlackjack) {
        return 0;
      }

      return 1.5;
    }

    if (dealer.isBlackjack) {
      return -1;
    }

    // Player Turn
    while (true) {

      final action = strategy.decide(
        player,
        dealer.cards.first,
      );

      if (action == 'stand') {
        break;
      }

      if (action == 'hit') {

        player.addCard(shoe.deal());

        if (player.isBust) {
          return -1;
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
        hitSoft17
      ) {
        dealer.addCard(shoe.deal());
      }
      else {
        break;
      }
    }

    if (dealer.isBust) {
      return 1;
    }

    if (player.value > dealer.value) {
      return 1;
    }

    if (player.value < dealer.value) {
      return -1;
    }

    return 0;
  }
}