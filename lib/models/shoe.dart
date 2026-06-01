import 'dart:math';

import 'card_model.dart';

import '../services/sound_service.dart';

class Shoe {
  final int decks;
  final List<PlayingCard> cards = [];

  Shoe({this.decks = 6}) {
    build();
    shuffle();
  }

  void build() {
    cards.clear();

    const suits = Suit.values;

    final ranks = [
      '2', '3', '4', '5', '6',
      '7', '8', '9', '10',
      'J', 'Q', 'K', 'A'
    ];

    for (int d = 0; d < decks; d++) {
      for (final suit in suits) {
        for (final rank in ranks) {
          cards.add(
            PlayingCard(
              rank: rank,
              suit: suit,
            ),
          );
        }
      }
    }
  }

  void shuffle() {
    cards.shuffle(Random());
  }

  PlayingCard deal() {
    if (cards.length < 104) {
      build();
      shuffle();
    }

    SoundService.instance.playCardDeal();
    return cards.removeLast();
  }
}