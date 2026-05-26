import 'hand.dart';

class PlayerHand extends Hand {

  double bet;

  bool doubled = false;

  bool finished = false;

  bool surrendered = false;

  PlayerHand({
    this.bet = 1,
  });

  void doubleDown() {
    bet *= 2;
    doubled = true;
  }
}