import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/debug.dart';
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
import 'package:gaurds_game/game/level07/game_level_seven.dart';
import 'package:gaurds_game/game/level09/game_level_nine.dart';
import 'package:gaurds_game/game/level10/finale.dart';

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

    add(FpsTextComponent(
        position: Vector2(30, 20),
        textRenderer: TextPaint(style: const TextStyle(color: Colors.black))));
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
      case 9:
        levelComponent = GameLevelNine(level: level);
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
        FlameAudio.bgm.play('level-five music.mp3', volume: .80);

        break;
      default:
        FlameAudio.bgm.play('level-five music.mp3', volume: .25);
    }
  }

  @override
  void onDispose() {
    FlameAudio.bgm.stop();
    FlameAudio.audioCache.clearAll();
    (levelComponent as LevelInterface).player?.dispose();
    super.onDispose();
  }
}
