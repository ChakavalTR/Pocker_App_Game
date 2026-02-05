import 'package:flutter/material.dart';

enum Suit { Hearts, Diamonds, Clubs, Spades, Others }

class CardModel {
  final Suit suit;
  final String image;
  final String value;

  CardModel({required this.suit, required this.image, required this.value});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      suit: stringToSuit(json['suit']),
      image: json['image'],
      value: json['value'],
    );
  }

  static Suit stringToSuit(String suit) {
    switch (suit.toUpperCase().trim()) {
      case 'HEARTS':
        return Suit.Hearts;
      case 'DIAMONDS':
        return Suit.Diamonds;
      case 'CLUBS':
        return Suit.Clubs;
      case 'SPADES':
        return Suit.Spades;
      default:
        return Suit.Others;
    }
  }

  static String suitToString(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
        return "HEARTS";
      case Suit.Diamonds:
        return "DIAMONDS";
      case Suit.Clubs:
        return "CLUBS";
      case Suit.Spades:
        return "SPADES";
      case Suit.Others:
        return "OTHERS";
    }
  }

  static String suitToUnicode(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
        return "\u2665";
      case Suit.Diamonds:
        return "\u2666";
      case Suit.Clubs:
        return "\u2663";
      case Suit.Spades:
        return "\u2660";
      case Suit.Others:
        return "Others";
    }
  }

  static Color suitToColor(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
      case Suit.Diamonds:
        return Color(0xFFFF0000); // Red color
      default:
        return Color(0xFF000000); // Black color
    }
  }
}
