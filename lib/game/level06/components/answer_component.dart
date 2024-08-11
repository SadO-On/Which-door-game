import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';

class AnswerComponent extends SvgComponent {
  AnswerComponent(this.text, this.index);

  String text;
  int index;
  TextComponent? answer;
  @override
  FutureOr<void> onLoad() async {
    final message = await Svg.load('images/message_empty.svg');
    svg = message;
    answer = TextComponent(
        text: text,
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
            style: const TextStyle(
                fontFamily: 'IMFellDoublePica',
                fontSize: 24,
                color: Colors.black)));
    await add(answer!);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    answer?.position =
        Vector2(this.size.x / 2, this.size.y / 2 - (answer?.size.y ?? 0) / 2);
    height = size.x * 0.07;
    width = size.x * 0.07;

    switch (index) {
      case 0:
        position = Vector2(size.x * 0.145, size.y * 0.32);
        break;
      case 1:
        position = Vector2(size.x * 0.375, size.y * 0.32);
        break;
      case 2:
        position = Vector2(size.x * 0.61, size.y * 0.32);
        break;
      case 3:
        position = Vector2(size.x * 0.845, size.y * 0.32);
        break;
      default:
    }
    super.onGameResize(size);
  }
}
