import '../models/hand.dart';
import '../models/card_model.dart';

abstract class Strategy {

  String decide({
    required Hand playerHand,
    required PlayingCard dealerUpcard,
    required bool canDouble,
    required bool canSplit,
  });
}