import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_screen.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

class GamePlayContainer extends StatelessWidget {
  const GamePlayContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: WhichDoorGameScreen(),
      overlayBuilderMap: {
        ChatScreen.overlayName: (context, WhichDoorGameScreen game) {
          return ChatScreen(levelNumber: 1, guardIndex: 0, gameScreen: game);
        }
      },
    );
  }
}
