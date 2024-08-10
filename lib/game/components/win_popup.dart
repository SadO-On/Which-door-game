import 'package:flutter/material.dart';
import 'package:gaurds_game/game/components/popup_container_widget.dart';
import 'package:gaurds_game/level/level_store.dart';
import 'package:gaurds_game/locator.dart';

import '../which_door_game_screen.dart';

class WinPopup extends StatelessWidget {
  WinPopup({super.key, required this.game, required this.gameContext});

  final WhichDoorGameScreen game;
  final BuildContext gameContext;
  static const String overlayName = "win_popup";

  final LevelStore _store = getIt.get<LevelStore>();
  @override
  Widget build(BuildContext context) {
    return PopupContainerWidget(
        asset: 'assets/images/correct_door.svg',
        btnText: 'Next',
        isAnimation: false,
        width: null,
        height: null,
        onClick: () async {
          await _store.saveNewLevel(game.level.id + 1).then((_) {
            Navigator.pop(context);
          });
        },
        text: 'You opened the right door!');
  }
}
