import 'dart:async';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:gaurds_game/game/level01/game_level_one.dart';

class WhichDoorGameScreen extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xffFFFDF2);

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() {
    add(GameLevelOne());
    return super.onLoad();
  }
}
