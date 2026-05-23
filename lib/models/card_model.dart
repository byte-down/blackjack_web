enum Suit {
  hearts,
  diamonds,
  clubs,
  spades,
}

class PlayingCard {
  final String rank;
  final Suit suit;

  PlayingCard({
    required this.rank,
    required this.suit,
  });

  int get value {
    switch (rank) {
      case 'A':
        return 11;

      case 'K':
      case 'Q':
      case 'J':
        return 10;

      default:
        return int.parse(rank);
    }
  }

  @override
  String toString() {
    return '$rank of $suit';
  }
}