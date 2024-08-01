import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:gaurds_game/game/level01/game_level_one.dart';

class ButtonComponent extends SpriteComponent
    with ParentIsA<GameLevelOne>, TapCallbacks {
  ButtonComponent(sprite) : super(sprite: sprite, size: Vector2(103, 28));
  @override
  FutureOr<void> onLoad() async {
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    parent.openChat();
    super.onTapDown(event);
  }
}
