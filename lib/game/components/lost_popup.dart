import 'package:flutter/material.dart';

import '../../data/model/level.dart';
import '../game_play_container.dart';
import '../which_door_game_screen.dart';
import 'popup_container_widget.dart';

class LostPopup extends StatelessWidget {
  const LostPopup({super.key, required this.game});

  final WhichDoorGameScreen game;

  static const String overlayName = "lost_popup";
  @override
  Widget build(BuildContext context) {
    return PopupContainerWidget(
        asset: 'assets/images/lost_door.svg',
        btnText: 'Retry',
        isAnimation: false,
        onClick: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GamePlayContainer(level: levels[game.level.id]!)),
          );
        },
        text: 'You opened the wrong door!');
  }
}
