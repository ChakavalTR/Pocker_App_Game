import 'package:flutter/material.dart';
import 'package:pocker_app_game/models/card_model.dart';

class _SuitOption {
  final Suit value;
  late Color color;
  late String label;
  _SuitOption({required this.value}) {
    this.color = CardModel.suitToColor(this.value);
    label = CardModel.suitToUnicode(value);
  }
}

class SuitChooseModal extends StatelessWidget {
  const SuitChooseModal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_SuitOption> suits = [
      _SuitOption(value: Suit.Clubs),
      _SuitOption(value: Suit.Hearts),
      _SuitOption(value: Suit.Spades),
      _SuitOption(value: Suit.Diamonds),
    ];
    return AlertDialog(
      title: Text('Choose a suit'),
      content: Row(
        children: suits
            .map(
              (suit) => TextButton(
                onPressed: () {
                  Navigator.of(context).pop(suit.value);
                },
                child: Text(
                  suit.label,
                  style: TextStyle(
                    color: suit.color,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
