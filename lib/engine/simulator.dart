import 'blackjack_game.dart';

class Simulator {

  final BlackjackGame game;

  Simulator(this.game);

  Map<String, dynamic> run(int hands) {

    double bankroll = 0;

    int wins = 0;
    int losses = 0;
    int pushes = 0;

    for (int i = 0; i < hands; i++) {

      final result = game.playHand();

      bankroll += result;

      if (result > 0) {
        wins++;
      }
      else if (result < 0) {
        losses++;
      }
      else {
        pushes++;
      }
    }

    return {
      'hands': hands,
      'bankroll': bankroll,
      'wins': wins,
      'losses': losses,
      'pushes': pushes,
      'evPerHand': bankroll / hands,
    };
  }
}