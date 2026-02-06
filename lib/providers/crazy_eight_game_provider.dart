import 'package:flutter/material.dart';
import 'package:pocker_app_game/components/suit_chooser_modal.dart';
import 'package:pocker_app_game/constants.dart';
import 'package:pocker_app_game/main.dart';
import 'package:pocker_app_game/models/card_model.dart';
import 'package:pocker_app_game/providers/game_provider.dart';

class CrazyEightsGameProvider extends GameProvider {
  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCards(p, count: 8, allowAnyTime: true);
    }
    await drawCardToDiscardPile();
    setLastPlayed(discardTop!);
  }

  @override
  bool get canEndTurn {
    if (turn.drawCount > 0 || turn.actionCount > 0) {
      return true;
    }
    return false;
  }

  @override
  bool canPlayCard(CardModel card) {
    bool canPlay = false;
    if (gameState[GS_LAST_SUIT] == null || gameState[GS_LAST_VALUE] == null) {
      return false;
    }

    if (gameState[GS_LAST_SUIT] == card.suit) {
      canPlay = true;
    }

    if (gameState[GS_LAST_VALUE] == card.value) {
      canPlay = true;
    }

    if (card.value == '8') {
      canPlay = true;
    }
    return canPlay;
  }

  @override
  Future<void> applyCardSideEffects(CardModel card) async {
    //8
    if (card.value == "8") {
      Suit? suit;

      if (turn.currentPlayer.isHuman) {
        suit = await showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => SuitChooseModal(),
          barrierDismissible: false,
        );
      } else {
        suit = turn.currentPlayer.cards.first.suit;
      }
      gameState[GS_LAST_SUIT] = suit;
    } else if (card.value == "2") {
      await drawCards(turn.otherPlayer, count: 2, allowAnyTime: true);
      showToast("${turn.otherPlayer.name} has to draw 2 cards!");
    } else if (card.value == "QUEEN" && card.suit == Suit.Spades) {
      await drawCards(turn.otherPlayer, count: 5, allowAnyTime: true);
      showToast("${turn.otherPlayer.name} has to draw 5 cards!");
    } else if (card.value == "JACK") {
      showToast("${turn.otherPlayer.name} missed a turn!");
      skipTurn();
    }
    notifyListeners();
  }

  @override
  Future<void> botTurn() async {
    final p = turn.currentPlayer;

    await Future.delayed(const Duration(milliseconds: 500));
    for (final c in turn.currentPlayer.cards) {
      if (canPlayCard(c)) {
        await playCard(player: p, card: c);
        endTurn();
        return;
      }
    }
    await Future.delayed(const Duration(milliseconds: 500));
    await drawCards(p);
    await Future.delayed(const Duration(milliseconds: 500));

    if (canPlayCard(p.cards.last)) {
      await playCard(player: p, card: p.cards.last);
    }
    endTurn();
  }
}
