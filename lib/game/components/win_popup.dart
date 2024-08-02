import 'package:flutter/material.dart';
import 'package:gaurds_game/game/components/popup_container_widget.dart';
import 'package:gaurds_game/game/game_play_container.dart';

import '../../data/model/level.dart';
import '../which_door_game_screen.dart';

class WinPopup extends StatelessWidget {
  const WinPopup({super.key, required this.game});

  final WhichDoorGameScreen game;

  static const String overlayName = "win_popup";
  @override
  Widget build(BuildContext context) {
    return PopupContainerWidget(
        asset: 'assets/images/correct_door.svg',
        btnText: 'Next',
        isAnimation: false,
        width: null,
        height: null,
        onClick: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GamePlayContainer(level: levels[game.level.id]!)),
          );
        },
        text: 'You opened the right door!');
  }
}
