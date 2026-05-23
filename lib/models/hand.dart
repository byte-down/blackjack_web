import 'card_model.dart';

class Hand {
  final List<PlayingCard> cards = [];

  void addCard(PlayingCard card) {
    cards.add(card);
  }

  int get value {
    int total = 0;
    int aces = 0;

    for (final card in cards) {
      total += card.value;

      if (card.rank == 'A') {
        aces++;
      }
    }

    while (total > 21 && aces > 0) {
      total -= 10;
      aces--;
    }

    return total;
  }

  bool get isSoft {
    int total = 0;
    int aces = 0;

    for (final card in cards) {
      total += card.value;

      if (card.rank == 'A') {
        aces++;
      }
    }

    return aces > 0 && total <= 21;
  }

  bool get isBust => value > 21;

  bool get isBlackjack =>
      cards.length == 2 && value == 21;
}