import 'package:flutter/material.dart';
import 'package:pocker_app_game/constants.dart';
import 'package:pocker_app_game/main.dart';
import 'package:pocker_app_game/models/card_model.dart';
import 'package:pocker_app_game/models/deck_model.dart';
import 'package:pocker_app_game/models/player_model.dart';
import 'package:pocker_app_game/models/turn_model.dart';
import 'package:pocker_app_game/services/deck_service.dart';

abstract class GameProvider with ChangeNotifier {
  GameProvider() {
    _service = DeckService();
  }
  late DeckService _service;
  late TurnModel _turn;
  TurnModel get turn => _turn;

  DeckModel? _currentDeck;
  DeckModel? get currentDeck => _currentDeck;

  List<PlayerModel> _players = [];
  List<PlayerModel> get players => _players;

  List<CardModel> _discards = [];
  List<CardModel> get discards => _discards;

  CardModel? get discardTop => _discards.isEmpty ? null : _discards.last;
  Map<String, dynamic> gameState = {};

  Future<void> newGame(List<PlayerModel> players) async {
    final deck = await _service.newDeck();
    _currentDeck = deck;
    _players = players;
    _discards = [];
    _turn = TurnModel(players: players, currentPlayer: players.first);
    setupBoard();
    notifyListeners();
  }

  void setLastPlayed(CardModel card) {
    gameState[GS_LAST_SUIT] = card.suit;
    gameState[GS_LAST_VALUE] = card.suit;
    notifyListeners();
  }

  Future<void> setupBoard() async {}
  bool get canDrawCard {
    return turn.drawCount < 1;
  }

  Future<void> drawCardToDiscardPile({int count = 1}) async {
    final draw = await _service.drawCards(_currentDeck!, count: count);

    _discards.addAll(draw.cards);
    _currentDeck!.remaining = draw.remaining;
    notifyListeners();
  }

  Future<void> drawCards(
    PlayerModel player, {
    int count = 1,
    bool allowAnyTime = false,
  }) async {
    if (currentDeck == null) return;
    if (!allowAnyTime && !canDrawCard) return;
    final draw = await _service.drawCards(_currentDeck!, count: count);
    player.addCard(draw.cards);

    _turn.drawCount += count;
    _currentDeck!.remaining = draw.remaining;
    notifyListeners();
  }

  bool canPlayCard(CardModel card) {
    return _turn.actionCount < 1;
  }

  Future<void> playCard({
    required PlayerModel player,
    required CardModel card,
  }) async {
    if (!canPlayCard(card)) return;

    player.removeCard(card);

    _discards.add(card);

    _turn.actionCount += 1;

    setLastPlayed(card);

    await applyCardSideEffects(card);

    notifyListeners();
  }

  Future<void> applyCardSideEffects(CardModel card) async {}
  bool get canEndTurn {
    return turn.drawCount > 0;
  }

  void endTurn() {
    _turn.nextTurn();
    if (_turn.currentPlayer.isBot) {
      botTurn();
    }
    notifyListeners();
  }

  void skipTurn() {
    _turn.nextTurn();
    _turn.nextTurn();
    notifyListeners();
  }

  Future<void> botTurn() async {
    await Future.delayed(Duration(milliseconds: 500));
    await drawCards(_turn.currentPlayer);
    await Future.delayed(Duration(milliseconds: 500));
    if (_turn.currentPlayer.cards.isNotEmpty) {
      await Future.delayed(Duration(milliseconds: 1000));
      playCard(
        player: _turn.currentPlayer,
        card: _turn.currentPlayer.cards.first,
      );
    }

    if (canEndTurn) {
      endTurn();
    }
  }

  void showToast(String message, {int seconds = 3, SnackBarAction? action}) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: seconds),
        action: action,
      ),
    );
  }
}
