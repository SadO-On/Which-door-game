import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_screen.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

class GamePlayContainer extends StatelessWidget {
  const GamePlayContainer({super.key, required this.level});

  final Level level;
  @override
  Widget build(BuildContext context) {
    return GameWidget.controlled(
      gameFactory: () {
        return WhichDoorGameScreen(level: level);
      },
      overlayBuilderMap: {
        ChatScreen.overlayName: (context, WhichDoorGameScreen game) {
          return ChatScreen(levelNumber: level.id, gameScreen: game);
        }
      },
    );
  }
}
