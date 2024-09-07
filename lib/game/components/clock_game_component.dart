import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ClockGameComponent extends Component with HasGameRef {
  @override
  FutureOr<void> onLoad() {
    add(RectangleComponent(
        paint: Paint()..color = Colors.black45, size: gameRef.size));
    return super.onLoad();
  }
}
