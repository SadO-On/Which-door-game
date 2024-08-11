import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/utils/theme.dart';

class MissionComponent extends TextBoxComponent with HasGameRef {
  MissionComponent(
      {required String text, this.isWithClock = false, double m = 400})
      : super(
          text: text,
          boxConfig: TextBoxConfig(timePerChar: 0.05, maxWidth: m),
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
        svg: svgClockInstance,
      );

      clockRight = SvgComponent(
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
    clockLeft?.size = Vector2.all(size.x * 0.06);
    clockRight?.size = Vector2.all(size.x * 0.06);

    position = Vector2((size.x / 2 - width / 2), 16);
    clockLeft?.position = Vector2(size.x * 0.17 - (size.x / 2 - width / 2), 0);
    clockRight?.position = Vector2(size.x * 0.53, 0);
    super.onGameResize(size);
  }
}
