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

  String get imageFileName {

    String suitName = '';

    switch (suit) {

      case Suit.spades:
        suitName = 'spade';
        break;

      case Suit.hearts:
        suitName = 'heart';
        break;

      case Suit.diamonds:
        suitName = 'diamond';
        break;

      case Suit.clubs:
        suitName = 'club';
        break;
    }

    String rankName = '';

    switch (rank) {

      case 'A':
        rankName = '1';
        break;

      case 'J':
        rankName = 'jack';
        break;

      case 'Q':
        rankName = 'queen';
        break;

      case 'K':
        rankName = 'king';
        break;

      default:
        rankName = rank;
    }

    return '${suitName}_$rankName.png';
  }

  @override
  String toString() {
    return '$rank of $suit';
  }
}