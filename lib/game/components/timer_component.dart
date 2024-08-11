import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/utils/theme.dart';
import 'package:gaurds_game/utils/utils.dart';

class LevelTimerComponent extends TextBoxComponent {
  LevelTimerComponent(this.time, String text, this.onDone)
      : super(
          text: text,
          boxConfig: const TextBoxConfig(
            timePerChar: 0.05,
            maxWidth: 40,
          ),
        );

  final bgPaint = Paint()..color = brown;
  final Timer _timer = Timer(1, repeat: true);
  final Function onDone;
  double time;
  @override
  Future<void> onLoad() {
    _timer.onTick = () {
      if (time <= 0) {
        _timer.stop();
        onDone();
      }
      time -= 1;
      text = time.toMMSS();
    };
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

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
    position = Vector2((size.x / 2 - width / 2) - 240, 16);
    super.onGameResize(size);
  }
}
