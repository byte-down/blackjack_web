import '../models/hand.dart';
import '../models/card_model.dart';

abstract class Strategy {
  String decide(
    Hand playerHand,
    PlayingCard dealerUpcard,
  );
}