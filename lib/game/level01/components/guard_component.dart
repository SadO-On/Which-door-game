import 'dart:async';

import 'package:flame_rive/flame_rive.dart';

class GuardComponent extends RiveComponent {
  GuardComponent({required super.artboard});

  @override
  FutureOr<void> onLoad() async {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return super.onLoad();
  }
}
