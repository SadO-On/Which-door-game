import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/game/components/popup_container_widget.dart';
import 'package:gaurds_game/level/level_store.dart';
import 'package:gaurds_game/locator.dart';

import '../../utils/routes.dart';
import '../which_door_game_screen.dart';

class WinPopup extends StatefulWidget {
  const WinPopup({super.key, required this.game, required this.gameContext});

  final WhichDoorGameScreen game;
  final BuildContext gameContext;
  static const String overlayName = "win_popup";

  @override
  State<WinPopup> createState() => _WinPopupState();
}

class _WinPopupState extends State<WinPopup> {
  final LevelStore _store = getIt.get<LevelStore>();
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playSound();
  }

  Future<void> playSound() async {
    await _player.play(AssetSource('audio/win sound.mp3'));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupContainerWidget(
        asset: 'assets/images/correct_door.svg',
        btnText: 'Next',
        isAnimation: false,
        width: null,
        height: null,
        onClick: () async {
          if (widget.game.level.id == 7) {
            Navigator.pushReplacementNamed(context, AppRoutes.cutScene,
                arguments: "assets/videos/final-cut-scene.mp4");
          } else {
            await _store.saveNewLevel(widget.game.level.id + 1).then((_) {
              Navigator.pop(context);
            });
          }
        },
        text: 'You opened the right door!');
  }
}
