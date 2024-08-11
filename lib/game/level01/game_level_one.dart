import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:gaurds_game/chat/chat_screen.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/components/guard_id_popup.dart';
import 'package:gaurds_game/game/components/lost_popup.dart';
import 'package:gaurds_game/game/components/rive_button_component.dart';
import 'package:gaurds_game/game/components/win_popup.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../components/mission_component.dart';
import 'components/guard_component.dart';
import 'components/lamp_component.dart';

class GameLevelOne extends Component
    with HasGameRef<WhichDoorGameScreen>, TapCallbacks {
  GameLevelOne({required this.level});

  final Level level;
  GuardComponent? willy;
  GuardComponent? steve;
  RiveButtonComponent? viewWillyIdComponent;
  RiveButtonComponent? viewSteveIdComponent;
  RiveButtonComponent? chatWithSteveComponent;
  RiveButtonComponent? chatWithWillyComponent;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  LampComponent? lampAnimation;

  @override
  FutureOr<void> onLoad() async {
    add(MissionComponent(text: level.riddle));
    final steveArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/steve_idle_standing.riv'));
    steve = GuardComponent(artboard: steveArtBoard);

    final willyArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/willy_idle_standing.riv'));
    willy = GuardComponent(artboard: willyArtBoard);

    final lampArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/lamp_animation.riv'));
    lampAnimation = LampComponent(artboard: lampArtBoard);
    add(lampAnimation!);
    await _loadButtons();
    await add(steve!);
    add(willy!);

    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    final guardSize = Vector2(size.x * 0.11, size.y * 0.53);
    final btnSize = Vector2(size.x * 0.2, size.y * 0.13);
    final lampSize = Vector2(size.x * 0.12, size.y * 0.48);

    willy?.size = guardSize;
    steve?.size = guardSize;

    doorAButton?.size = btnSize;
    doorBButton?.size = btnSize;

    willy?.position =
        Vector2(size.x * 0.30 - (willy?.size.x ?? 0), size.y * 0.4);

    steve?.position =
        Vector2(size.x * 0.83 - (steve?.size.x ?? 0), size.y * 0.4);

    lampAnimation?.size = lampSize;
    lampAnimation?.position = Vector2(
        size.x * 0.43, size.y * 0.61 - (lampAnimation?.size.y ?? 0) / 3);

    _optionsSizing(size, btnSize);

    doorAButton?.position = Vector2(
        size.x * 0.09 - (doorAButton?.size.x ?? 0) / 6,
        (size.y * 0.5 - (viewWillyIdComponent?.height ?? 0)));

    doorBButton?.position = Vector2(
        size.x * 0.62 - (doorBButton?.size.x ?? 0) / 6,
        (size.y * 0.5 - (viewSteveIdComponent?.height ?? 0)));

    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size, Vector2 btnSize) {
    chatWithWillyComponent?.size = btnSize;
    chatWithSteveComponent?.size = btnSize;

    viewWillyIdComponent?.size = btnSize;
    viewSteveIdComponent?.size = btnSize;

    chatWithWillyComponent?.position = Vector2(
        size.x * 0.09 - (chatWithWillyComponent?.size.x ?? 0) / 6,
        size.y * 0.5);

    chatWithSteveComponent?.position = Vector2(
        size.x * 0.62 - (chatWithSteveComponent?.size.x ?? 0) / 6,
        size.y * 0.5);

    viewSteveIdComponent?.position = Vector2(
        size.x * 0.62 - (viewSteveIdComponent?.size.x ?? 0) / 6,
        (size.y * 0.5 - (viewWillyIdComponent?.height ?? 0)));

    viewWillyIdComponent?.position = Vector2(
        size.x * 0.09 - (viewWillyIdComponent?.size.x ?? 0) / 6,
        (size.y * 0.5 - (viewSteveIdComponent?.height ?? 0)));
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.showOverlay(ChatScreen.overlayName);
  }

  Future _loadButtons() async {
    final chatWithWillyArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final chatWithSteveArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final viewWillyIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final viewSteveIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));

    doorAButton = RiveButtonComponent(aDoorArtBoard, 'Door A', () {
      if (level.correctDoor == "A") {
        gameRef.showOverlay(WinPopup.overlayName);
      } else {
        gameRef.showOverlay(LostPopup.overlayName);
      }
    });

    doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
      if (level.correctDoor == "B") {
        gameRef.showOverlay(WinPopup.overlayName);
      } else {
        gameRef.showOverlay(LostPopup.overlayName);
      }
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
      gameRef.guardIndex = 0;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    viewWillyIdComponent =
        RiveButtonComponent(viewWillyIdArtBoard, 'View Willy’s ID', () {
      gameRef.guardIndex = 1;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    await addAll([
      viewSteveIdComponent!,
      viewWillyIdComponent!,
      chatWithSteveComponent!,
      chatWithWillyComponent!
    ]);
  }

  void showOptions() async {
    removeAll([
      viewSteveIdComponent!,
      viewWillyIdComponent!,
      chatWithSteveComponent!,
      chatWithWillyComponent!
    ]);
    await addAll([doorAButton!, doorBButton!]);
  }
}
