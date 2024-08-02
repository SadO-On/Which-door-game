import 'dart:async';

import 'package:flame_rive/flame_rive.dart';

class LampComponent extends RiveComponent {
  LampComponent({required super.artboard});

  @override
  FutureOr<void> onLoad() async {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return super.onLoad();
  }
}
