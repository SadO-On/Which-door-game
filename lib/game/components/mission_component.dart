import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/utils/theme.dart';

class MissionComponent extends TextBoxComponent {
  MissionComponent({required String text, this.isWithClock = false})
      : super(
          text: text,
          boxConfig: const TextBoxConfig(timePerChar: 0.05, maxWidth: 400),
        );

  final bgPaint = Paint()..color = brown;
  final bool isWithClock;
  SvgComponent? clockLeft, clockRight;
  @override
  void render(Canvas canvas) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    canvas.drawRect(rect, bgPaint);
    super.render(canvas);
  }

  @override
  Future<void> onLoad() async {
    if (isWithClock) {
      final svgClockInstance = await Svg.load('images/clock_level_five.svg');

      clockLeft = SvgComponent(
        size: Vector2.all(50),
        svg: svgClockInstance,
      );

      clockRight = SvgComponent(
        size: Vector2.all(50),
        svg: svgClockInstance,
      );
      addAll([clockLeft!, clockRight!]);
    }
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    align = Anchor.center;
    textRenderer = TextPaint(
        style: const TextStyle(
      fontSize: 12,
      fontFamily: 'Impact',
    ));
    position = Vector2((size.x / 2 - width / 2), 16);
    clockLeft?.position = Vector2(position.x - size.x / 3 - 12, 0);
    clockRight?.position = Vector2(position.x + size.x / 5 - 12, 0);
    super.onGameResize(size);
  }
}
