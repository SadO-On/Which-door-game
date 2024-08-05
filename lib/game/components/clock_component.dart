import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';

class ClockComponent extends SvgComponent {
  @override
  FutureOr<void> onLoad() async {
    final message = await Svg.load('images/clock_level_five.svg');
    svg = message;
    size = Vector2.all(77);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    position = Vector2(size.x * 0.05, size.y * 0.10);
    super.onGameResize(size);
  }
}
