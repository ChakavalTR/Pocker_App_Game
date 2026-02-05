import 'package:flutter/material.dart';
import 'package:pocker_app_game/components/playing_card.dart';
import 'package:pocker_app_game/constants.dart';
import 'package:pocker_app_game/models/card_model.dart';
import 'package:pocker_app_game/models/player_model.dart';

class CardList extends StatelessWidget {
  final double size;
  final PlayerModel player;
  final Function(CardModel)? onPlayCard;

  const CardList({
    Key? key,
    required this.player,
    this.size = 1,
    this.onPlayCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, left: 8.0),
      child: SizedBox(
        height: CARD_HEIGHT * size,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: player.cards.length,
          itemBuilder: (context, index) {
            final card = player.cards[index];
            return Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: PlayingCard(card: card, size: size, visible: true),
            );
          },
        ),
      ),
    );
  }
}
