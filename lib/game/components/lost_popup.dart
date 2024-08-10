import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../which_door_game_screen.dart';
import 'popup_container_widget.dart';

class LostPopup extends StatefulWidget {
  const LostPopup({super.key, required this.game});

  final WhichDoorGameScreen game;
  static const String overlayName = "lost_popup";

  @override
  State<LostPopup> createState() => _LostPopupState();
}

class _LostPopupState extends State<LostPopup> {
  final _player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _player.setVolume(0.5);
    playSound();
  }

  Future<void> playSound() async {
    await _player.play(AssetSource('audio/lost sound.mp3'));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupContainerWidget(
        asset: 'assets/images/wrong_door.svg',
        btnText: 'Retry',
        isAnimation: false,
        width: null,
        height: null,
        onClick: () {
          Navigator.pop(context);
        },
        text: 'You opened the wrong door!');
  }
}
