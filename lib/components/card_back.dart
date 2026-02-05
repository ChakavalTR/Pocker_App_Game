import 'package:flutter/material.dart';
import 'package:pocker_app_game/constants.dart';

class CardBack extends StatelessWidget {
  final double size;
  final Widget? child;
  const CardBack({Key? key, this.size = 1, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CARD_WIDTH * size,
      height: CARD_HEIGHT * size,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.blueGrey,
      ),
      child: child ?? Container(),
    );
  }
}
