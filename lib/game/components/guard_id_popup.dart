import 'package:flutter/material.dart';
import 'package:gaurds_game/game/components/popup_container_widget.dart';

import '../../data/model/level.dart';
import '../which_door_game_screen.dart';

class GuardIdPopup extends StatelessWidget {
  const GuardIdPopup(
      {super.key, required this.game, required this.levelNumber});

  final WhichDoorGameScreen game;
  final int levelNumber;
  static const String overlayName = "guard_id_popup";
  @override
  Widget build(BuildContext context) {
    return PopupContainerWidget(
        asset: levels[levelNumber]!.guards[game.guardIndex].idAsset,
        btnText: 'Ok',
        width: 230,
        height: 120,
        isAnimation: false,
        onClick: () {
          game.hideOverlay(overlayName);
        },
        text: levels[levelNumber]!.guards[game.guardIndex].slogan);
  }
}
