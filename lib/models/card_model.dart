enum Suit { hearts, diamonds, clubs, spades, others }

class CardModel {
  final String suit;
  final String image;
  final String value;

  CardModel({required this.suit, required this.image, required this.value});
}
