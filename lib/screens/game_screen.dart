import 'package:flutter/material.dart';
import 'package:pocker_app_game/components/game_board.dart';
import 'package:pocker_app_game/services/deck_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    tempFunc();
  }

  void tempFunc() async {
    final service = DeckService();
    final deck = await service.newDeck();
    print(deck.remaining);
    print('--------------');
    final draw = await service.drawCards(deck, count: 7);
    print(draw.cards.length);
    print("--------------");
    print(draw.remaining);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          'Pocker Game',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'New Cards',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: const GameBoard(),
    );
  }
}
