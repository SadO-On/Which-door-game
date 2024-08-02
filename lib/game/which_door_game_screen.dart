import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/debug.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/game/components/win_popup.dart';
import 'package:gaurds_game/game/level01/game_level_one.dart';
import 'package:gaurds_game/game/level02/game_level_two.dart';

import '../data/model/level.dart';
import 'components/lost_popup.dart';

class WhichDoorGameScreen extends FlameGame {
  WhichDoorGameScreen({required this.level});
  @override
  Color backgroundColor() => const Color(0xffFFFDF2);

  final Level level;

  int guardIndex = 0;

  void setLandScape() {
    Flame.device.setLandscape();
  }

  @override
  FutureOr<void> onLoad() {
    setLandScape();

    add(FpsTextComponent(
        position: Vector2(30, 20),
        textRenderer: TextPaint(style: const TextStyle(color: Colors.black))));
    add(levelDecider());
    return super.onLoad();
  }

  void playerLost() {
    overlays.add(LostPopup.overlayName);
  }

  void playerWin() {
    overlays.add(WinPopup.overlayName);
  }

  Component levelDecider() {
    switch (level.id) {
      case 1:
        return GameLevelOne(level: level);
      case 2:
        return GameLevelTwo(level);
      default:
        return GameLevelOne(level: level);
    }
  }
}
