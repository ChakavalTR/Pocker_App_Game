import 'package:flutter/material.dart';
import 'package:pocker_app_game/components/game_board.dart';
import 'package:pocker_app_game/models/player_model.dart';
import 'package:pocker_app_game/providers/game_provider.dart';
import 'package:pocker_app_game/services/deck_service.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameProvider _gameProvider;
  @override
  void initState() {
    _gameProvider = Provider.of<GameProvider>(context, listen: false);
    super.initState();
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
            onPressed: () async {
              final players = [
                PlayerModel(name: 'Chakaval', isHuman: true),
                PlayerModel(name: 'Bot', isHuman: false),
              ];
              await _gameProvider.newGame(players);
            },
            child: Text(
              'New Game',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: GameBoard(),
      backgroundColor: Colors.green[800],
    );
  }
}
