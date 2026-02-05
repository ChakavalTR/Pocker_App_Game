import 'package:flutter/material.dart';
import 'package:pocker_app_game/components/card_list.dart';
import 'package:pocker_app_game/components/deck_pile.dart';
import 'package:pocker_app_game/components/playing_card.dart';
import 'package:pocker_app_game/models/card_model.dart';
import 'package:pocker_app_game/models/player_model.dart';
import 'package:pocker_app_game/providers/game_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui'; // For the blur effect

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, model, child) {
        return model.currentDeck != null
            ? Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        await model.drawCards(model.turn.currentPlayer);
                      },
                      child: DeckPile(remaining: model.currentDeck!.remaining),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.topCenter,
                    child: CardList(player: model.players[1]),
                  ),
                  Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (model.turn.currentPlayer == model.players[0])
                              ElevatedButton(
                                onPressed: model.canEndTurn
                                    ? () {
                                        model.endTurn();
                                      }
                                    : null,
                                child: const Text('End Turn'),
                              ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CardList(player: model.players[0]),
                      ],
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/cards/IMG_1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                      child: Container(color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          image: DecorationImage(
                            image: AssetImage('assets/cards/Pocker_Logo.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            final players = [
                              PlayerModel(name: 'Chakaval', isHuman: true),
                              PlayerModel(name: 'Bot', isHuman: false),
                            ];
                            model.newGame(players);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          child: Text(
                            'Press to Start Game',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
      },
    );
  }
}
