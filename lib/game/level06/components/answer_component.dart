import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AnswerComponent extends SvgComponent {
  AnswerComponent(this.text, this.index);

  String text;
  int index;
  TextComponent? answer;
  @override
  FutureOr<void> onLoad() async {
    final message = await Svg.load('images/message_empty.svg');
    svg = message;
    size = Vector2.all(61);
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

    switch (index) {
      case 0:
        position = Vector2(size.x * 0.215, size.y * 0.45);
        break;
      case 1:
        position = Vector2(size.x * 0.415, size.y * 0.45);
        break;
      case 2:
        position = Vector2(size.x * 0.615, size.y * 0.45);
        break;
      case 3:
        position = Vector2(size.x * 0.815, size.y * 0.45);
        break;
      default:
    }
    super.onGameResize(size);
  }
}
