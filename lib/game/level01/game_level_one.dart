import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:gaurds_game/game/components/rive_button_component.dart';
import 'package:gaurds_game/game/level01/components/button_component.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../components/mission_component.dart';
import 'components/guard_component.dart';

class GameLevelOne extends Component
    with HasGameRef<WhichDoorGameScreen>, TapCallbacks {
  late final SpriteComponent doorA;
  late final SpriteComponent doorB;
  late final SpriteComponent gaurd2;
  late final GuardComponent willy;
  late final RiveButtonComponent buttonComponent;
  @override
  FutureOr<void> onLoad() async {
    add(MissionComponent(
        'You have 3 questions. You can choose the guard you want to ask to find out who is the liar and who is the honest one.'));
    final sprite = await Sprite.load('door_a.png');
    final size = Vector2(130, 265);
    doorA = SpriteComponent(size: size, sprite: sprite);

    add(doorA);
    final spriteB = await Sprite.load('door_b.png');
    doorB = SpriteComponent(size: size, sprite: spriteB);
    add(doorB);

    final spriteGaurd = await Sprite.load('test_guard.png');
    final gaurdSize = Vector2(77, 222);

    gaurd2 = SpriteComponent(size: gaurdSize, sprite: spriteGaurd);
    add(gaurd2);

    final willyArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/willy_idle_standing.riv'));
    willy = GuardComponent(artboard: willyArtBoard);
    add(willy);

    final buttonArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    buttonComponent =
        RiveButtonComponent(buttonArtBoard, 'Chat with willy', () {
      print("cleck");
    });

    add(buttonComponent);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    doorA.position = Vector2(size.x * 0.25, size.y * 0.5 - doorA.size.y / 2);
    doorB.position = Vector2(size.x * 0.75, size.y * 0.5 - doorB.size.y / 2);

    willy.position = Vector2(
        size.x * 0.25 - (willy.size.x - 20), size.y * 0.5 - willy.size.y / 3);

    gaurd2.position = Vector2(
        size.x * 0.75 - (gaurd2.size.x - 20), size.y * 0.5 - gaurd2.size.y / 3);

    buttonComponent.position =
        Vector2(size.x * 0.10 - (willy.size.x - 20), size.y * 0.5);
    super.onGameResize(size);
  }

  void openChat() {
    gameRef.overlays.add("ChatScreen");
  }
}
