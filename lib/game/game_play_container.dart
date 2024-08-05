import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_screen.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/components/guard_id_popup.dart';
import 'package:gaurds_game/game/components/win_popup.dart';
import 'package:gaurds_game/game/level05/components/big_message_component.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import 'components/loading_screen.dart';
import 'components/lost_popup.dart';

class GamePlayContainer extends StatelessWidget {
  const GamePlayContainer({super.key, required this.level});

  final Level level;
  @override
  Widget build(BuildContext context) {
    return GameWidget(
        game: WhichDoorGameScreen(level: level),
        overlayBuilderMap: {
          ChatScreen.overlayName: (context, WhichDoorGameScreen game) =>
              ChatScreen(levelNumber: level.id, gameScreen: game),
          WinPopup.overlayName: (context, WhichDoorGameScreen game) => WinPopup(
                game: game,
              ),
          LostPopup.overlayName: (context, WhichDoorGameScreen game) =>
              LostPopup(game: game),
          GuardIdPopup.overlayName: (context, WhichDoorGameScreen game) =>
              GuardIdPopup(game: game, levelNumber: level.id),
          BigMessageComponent.overlayName:
              (context, WhichDoorGameScreen game) =>
                  BigMessageComponent(game: game),
          LoadingScreen.overlayName: (context, _) => const LoadingScreen()
        });
  }
}

// GameWidget.controlled(
//       gameFactory: () {
//         return WhichDoorGameScreen(level: level);
//       },
// overlayBuilderMap: {
//           ChatScreen.overlayName: (context, WhichDoorGameScreen game) =>
//               ChatScreen(levelNumber: level.id, gameScreen: game),
//           WinPopup.overlayName: (context, WhichDoorGameScreen game) => WinPopup(
//                 game: game,
//               ),
//           LostPopup.overlayName: (context, WhichDoorGameScreen game) =>
//               LostPopup(game: game),
//           GuardIdPopup.overlayName: (context, WhichDoorGameScreen game) =>
//               GuardIdPopup(game: game, levelNumber: level.id)
//         },
//     )



// GameWidget(
//         game: WhichDoorGameScreen(level: level),
//         overlayBuilderMap: {
//           ChatScreen.overlayName: (context, WhichDoorGameScreen game) =>
//               ChatScreen(levelNumber: level.id, gameScreen: game),
//           WinPopup.overlayName: (context, WhichDoorGameScreen game) => WinPopup(
//                 game: game,
//               ),
//           LostPopup.overlayName: (context, WhichDoorGameScreen game) =>
//               LostPopup(game: game),
//           GuardIdPopup.overlayName: (context, WhichDoorGameScreen game) =>
//               GuardIdPopup(game: game, levelNumber: level.id)
//         });