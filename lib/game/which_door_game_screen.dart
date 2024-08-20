import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/game/components/back_button_game_overlay.dart';
import 'package:gaurds_game/game/level01/game_level_one.dart';
import 'package:gaurds_game/game/level02/game_level_two.dart';
import 'package:gaurds_game/game/level03/game_level_three.dart';
import 'package:gaurds_game/game/level04/gameLevelFour.dart';
import 'package:gaurds_game/game/level05/game_level_five.dart';
import 'package:gaurds_game/game/level06/game_level_six.dart';
import 'package:gaurds_game/game/finale/finale.dart';
import 'package:gaurds_game/game/level07/game_level_seven.dart';

import '../data/model/level.dart';
import 'level_interface.dart';

class WhichDoorGameScreen extends FlameGame {
  WhichDoorGameScreen({required this.level});
  @override
  Color backgroundColor() => const Color(0xffFFFDF2);

  final Level level;
  Component? levelComponent;
  int guardIndex = 0;

  FutureOr<void> setLandScape() async {
    await Flame.device.setLandscape();
  }

  @override
  FutureOr<void> onLoad() async {
    await setLandScape();
    await add(levelDecider());
    playLevelMusic();
    showOverlay(BackButtonGameOverlay.overlayName);
    return super.onLoad();
  }

  Component levelDecider() {
    switch (level.id) {
      case 1:
        levelComponent = GameLevelOne(level: level);
        return levelComponent!;
      case 2:
        levelComponent = GameLevelTwo(level: level);
        return levelComponent!;
      case 3:
        levelComponent = GameLevelThree(level: level);
        return levelComponent!;
      case 4:
        levelComponent = GameLevelFour(level: level);
        return levelComponent!;
      case 5:
        levelComponent = GameLevelFive(level: level);
        return levelComponent!;
      case 6:
        levelComponent = GameLevelSix(level: level);
        return levelComponent!;
      case 7:
        levelComponent = GameLevelSeven(level: level);
        return levelComponent!;
      case 10:
        levelComponent = Finale(level: level);
        return levelComponent!;
      default:
        levelComponent = GameLevelOne(level: level);
        return levelComponent!;
    }
  }

  void hideOverlay(String overlayName) {
    overlays.remove(overlayName);
  }

  void showOverlay(String overlayName) {
    overlays.add(overlayName);
  }

  void playLevelMusic() {
    switch (level.id) {
      case 5:
        FlameAudio.bgm.play('level-five music.mp3', volume: .75);
        break;
      case 7:
        FlameAudio.bgm.play('final_level_music.mp3', volume: .75);
        break;
      default:
        FlameAudio.bgm.play('levels-soundtrack.mp3', volume: .40);
    }
  }

  @override
  void onDispose() {
    FlameAudio.bgm.stop();
    FlameAudio.audioCache.clearAll();
    if (levelComponent is LevelInterface) {
      (levelComponent as LevelInterface).player?.dispose();
    }
    super.onDispose();
  }
}
