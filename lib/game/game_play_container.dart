import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaurds_game/chat/chat_screen.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/components/back_button_game_overlay.dart';
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
    return GameWidget.controlled(
      gameFactory: () {
        return WhichDoorGameScreen(level: level);
      },
      backgroundBuilder: (context) => SvgPicture.asset(
        level.backgroundAssets,
        fit: BoxFit.fill,
        semanticsLabel: 'Image of dark brown door in the right of the screen',
      ),
      loadingBuilder: (ctx) => const LoadingScreen(),
      overlayBuilderMap: {
        ChatScreen.overlayName: (secondContext, WhichDoorGameScreen game) =>
            ChatScreen(levelNumber: level.id, gameScreen: game),
        WinPopup.overlayName: (secondContext, WhichDoorGameScreen game) =>
            WinPopup(
              game: game,
              gameContext: context,
            ),
        LostPopup.overlayName: (context, WhichDoorGameScreen game) =>
            LostPopup(game: game),
        GuardIdPopup.overlayName: (context, WhichDoorGameScreen game) =>
            GuardIdPopup(game: game, levelNumber: level.id),
        BigMessageComponent.overlayName: (context, WhichDoorGameScreen game) =>
            BigMessageComponent(game: game),
        LoadingScreen.overlayName: (context, _) => const LoadingScreen(),
        BackButtonGameOverlay.overlayName: (context, _) =>
            const BackButtonGameOverlay()
      },
    );
  }
}



// GameWidget(
//       game: WhichDoorGameScreen(level: level),
//       backgroundBuilder: (context) => SvgPicture.asset(
//         level.backgroundAssets,
//         fit: BoxFit.fill,
//         semanticsLabel: 'Image of dark brown door in the right of the screen',
//       ),
//       loadingBuilder: (ctx) => const LoadingScreen(),
//       overlayBuilderMap: {
//         ChatScreen.overlayName: (secondContext, WhichDoorGameScreen game) =>
//             ChatScreen(levelNumber: level.id, gameScreen: game),
//         WinPopup.overlayName: (secondContext, WhichDoorGameScreen game) =>
//             WinPopup(
//               game: game,
//               gameContext: context,
//             ),
//         LostPopup.overlayName: (context, WhichDoorGameScreen game) =>
//             LostPopup(game: game),
//         GuardIdPopup.overlayName: (context, WhichDoorGameScreen game) =>
//             GuardIdPopup(game: game, levelNumber: level.id),
//         BigMessageComponent.overlayName: (context, WhichDoorGameScreen game) =>
//             BigMessageComponent(game: game),
//         LoadingScreen.overlayName: (context, _) => const LoadingScreen(),
//         BackButtonGameOverlay.overlayName: (context, _) =>
//             const BackButtonGameOverlay()
//       },
//     );