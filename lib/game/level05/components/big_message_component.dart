import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

class BigMessageComponent extends StatelessWidget {
  const BigMessageComponent({super.key, required this.game});
  final WhichDoorGameScreen game;
  static const String overlayName = "message_component";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () {
              game.hideOverlay(overlayName);
            },
            child: SvgPicture.asset('assets/images/message_close.svg',
                width: 200,
                height: 200,
                semanticsLabel:
                    'Message form other guard it says: I\'m going to have breakfast and I\'ll be back.'),
          )
        ],
      ),
    );
  }
}
