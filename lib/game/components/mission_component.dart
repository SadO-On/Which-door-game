import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/utils/theme.dart';

class MissionComponent extends TextBoxComponent {
  MissionComponent(String text)
      : super(
          text: text,
          boxConfig: const TextBoxConfig(timePerChar: 0.05, maxWidth: 400),
        );

  final bgPaint = Paint()..color = brown;

  @override
  void render(Canvas canvas) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    canvas.drawRect(rect, bgPaint);
    super.render(canvas);
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
    super.onGameResize(size);
  }
}
