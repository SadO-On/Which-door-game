import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:gaurds_game/game/level05/game_level_five.dart';

class MessageComponent extends SvgComponent
    with TapCallbacks, ParentIsA<GameLevelFive> {
  @override
  FutureOr<void> onLoad() async {
    final message = await Svg.load('images/message_close.svg');
    svg = message;
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    height = size.x * 0.07;
    width = size.x * 0.07;

    position = Vector2(size.x * 0.815, size.y * 0.35);
    super.onGameResize(size);
  }
}
