import '../models/card_model.dart';
import '../models/hand.dart';

import 'strategy.dart';

class BasicStrategy implements Strategy {

  @override
  String decide({
    required Hand playerHand,
    required PlayingCard dealerUpcard,
    required bool canDouble,
    required bool canSplit,
  }) {

    final total = playerHand.value;

    final dealer = dealerUpcard.value;

    // Splits

    if (canSplit) {

      final rank = playerHand.cards.first.rank;

      if (rank == 'A' || rank == '8') {
        return 'split';
      }
    }

    // Doubles

    if (canDouble) {

      if (total == 11) {
        return 'double';
      }

      if (total == 10 && dealer <= 9) {
        return 'double';
      }
    }

    // Normal Strategy

    if (total <= 11) {
      return 'hit';
    }

    if (total >= 17) {
      return 'stand';
    }

    if (total >= 12 && dealer <= 6) {
      return 'stand';
    }

    return 'hit';
  }
}