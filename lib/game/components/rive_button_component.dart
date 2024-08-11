import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';

class RiveButtonComponent extends RiveComponent with TapCallbacks {
  RiveButtonComponent(Artboard artBoard, this.text, this.onClick)
      : super(artboard: artBoard);

  late final TextComponent textComponent;
  final String text;
  final Function onClick;
  late final SMITrigger? _trigger;
  late StateMachineController? _controller;
  final _effect = MoveByEffect(
    Vector2(4, 0),
    EffectController(
      duration: 0.5,
      reverseDuration: 0.5,
    ),
  );
  @override
  FutureOr<void> onLoad() async {
    _controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(_controller!);
    textComponent = TextComponent(
        text: text,
        textRenderer: TextPaint(
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'IMFellDoublePica',
                fontSize: 10)));
    _trigger = _controller?.findSMI('Button click');
    add(textComponent);

    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    textComponent.position =
        Vector2(width / 2 - (textComponent.size.x / 2) - 4, height * 0.4);
    super.onGameResize(size);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _trigger?.fire();
    textComponent.add(_effect);
    _effect.reset();

    Future.delayed(const Duration(milliseconds: 1000), () {
      onClick();
    });

    super.onTapDown(event);
  }
}
