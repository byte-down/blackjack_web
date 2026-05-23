import '../models/card_model.dart';
import '../models/hand.dart';
import 'strategy.dart';

class BasicStrategy implements Strategy {

  @override
  String decide(
    Hand playerHand,
    PlayingCard dealerUpcard,
  ) {

    final total = playerHand.value;
    final dealerValue = dealerUpcard.value;

    if (total <= 11) {
      return 'hit';
    }

    if (total >= 17) {
      return 'stand';
    }

    if (total >= 12 && dealerValue <= 6) {
      return 'stand';
    }

    return 'hit';
  }
}