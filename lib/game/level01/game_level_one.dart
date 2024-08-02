import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/services.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/components/rive_button_component.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../components/mission_component.dart';
import 'components/guard_component.dart';

class GameLevelOne extends Component
    with HasGameRef<WhichDoorGameScreen>, TapCallbacks {
  GameLevelOne({required this.level});

  final Level level;
  late final SpriteComponent doorA;
  late final SpriteComponent doorB;
  late final GuardComponent willy;
  late final GuardComponent steve;
  late final RiveButtonComponent viewWillyIdComponent;
  late final RiveButtonComponent viewSteveIdComponent;
  late final RiveButtonComponent chatWithSteveComponent;
  late final RiveButtonComponent chatWithWillyComponent;
  late final RiveButtonComponent doorAButton;
  late final RiveButtonComponent doorBButton;

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

    final steveArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/steve_idle_standing.riv'));
    steve = GuardComponent(artboard: steveArtBoard);
    add(steve);

    final willyArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/willy_idle_standing.riv'));
    willy = GuardComponent(artboard: willyArtBoard);
    add(willy);

    await _loadButtons();
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    doorA.position = Vector2(size.x * 0.25, size.y * 0.5 - doorA.size.y / 2);
    doorB.position = Vector2(size.x * 0.75, size.y * 0.5 - doorB.size.y / 2);

    willy.position = Vector2(
        size.x * 0.25 - (willy.size.x - 20), size.y * 0.5 - willy.size.y / 3);

    steve.position = Vector2(
        size.x * 0.75 - (steve.size.x - 20), size.y * 0.5 - steve.size.y / 3);

    chatWithWillyComponent.position =
        Vector2(size.x * 0.10 - (willy.size.x - 20), size.y * 0.5);

    chatWithSteveComponent.position =
        Vector2(size.x * 0.60 - (steve.size.x - 20), size.y * 0.5);

    viewSteveIdComponent.position = Vector2(size.x * 0.10 - (willy.size.x - 20),
        (size.y * 0.5 - viewSteveIdComponent.height));

    viewWillyIdComponent.position = Vector2(size.x * 0.60 - (steve.size.x - 20),
        (size.y * 0.5 - viewWillyIdComponent.height));

    doorAButton.position = Vector2(size.x * 0.60 - (steve.size.x - 20),
        (size.y * 0.5 - viewWillyIdComponent.height));

    doorBButton.position = Vector2(size.x * 0.10 - (willy.size.x - 20),
        (size.y * 0.5 - viewSteveIdComponent.height));
    super.onGameResize(size);
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.overlays.add("ChatScreen");
  }

  Future _loadButtons() async {
    final chatWithWillyArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final chatWithSteveArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewWillyIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewSteveIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    doorAButton = RiveButtonComponent(aDoorArtBoard, 'Door A', () {
      print("cleck"); //TODO win
    });

    doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
      print("cleck"); // TODO lose
    });

    chatWithWillyComponent =
        RiveButtonComponent(chatWithWillyArtBoard, 'Chat with Willy', () {
      gameRef.guardIndex = 1;
      openChat();
      showOptions();
    });

    chatWithSteveComponent =
        RiveButtonComponent(chatWithSteveArtBoard, 'Chat with Steve', () {
      gameRef.guardIndex = 0;
      openChat();
      showOptions();
    });

    viewSteveIdComponent =
        RiveButtonComponent(viewSteveIdArtBoard, 'View Steve’s ID', () {
      print("cleck");
    });

    viewWillyIdComponent =
        RiveButtonComponent(viewWillyIdArtBoard, 'View Willy’s ID', () {
      print("cleck");
    });

    await addAll([
      viewSteveIdComponent,
      viewWillyIdComponent,
      chatWithSteveComponent,
      chatWithWillyComponent
    ]);
  }

  void showOptions() async {
    removeAll([
      viewSteveIdComponent,
      viewWillyIdComponent,
      chatWithSteveComponent,
      chatWithWillyComponent
    ]);
    await addAll([doorAButton, doorBButton]);
  }
}
