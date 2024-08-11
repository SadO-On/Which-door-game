import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../../data/model/level.dart';
import '../components/guard_id_popup.dart';
import '../components/lost_popup.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../components/win_popup.dart';
import '../level01/components/guard_component.dart';
import '../level01/components/lamp_component.dart';

class Finale extends Component with HasGameRef<WhichDoorGameScreen> {
  Finale({required this.level});
  final Level level;

  GuardComponent? roger, newgate;
  RiveButtonComponent? viewNewgateIdComponent,
      viewRogerIdComponent,
      chatWithNewgateComponent,
      chatWithRogerComponent;
  RiveButtonComponent? doorAButton, doorBButton;
  LampComponent? lampAnimation;

  @override
  FutureOr<void> onLoad() async {
    add(MissionComponent(text: level.riddle));

    final newgateArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/newgate_standing_animation.riv'));
    newgate = GuardComponent(artboard: newgateArtBoard);
    final rogerArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/roger_standing_animation.riv'));
    roger = GuardComponent(artboard: rogerArtBoard);

    final lampArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/lamp_animation.riv'));
    lampAnimation = LampComponent(artboard: lampArtBoard);
    add(lampAnimation!);
    await _loadButtons();
    await addAll([roger!, newgate!]);

    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    final guardSize = Vector2(size.x * 0.11, size.y * 0.53);
    final btnSize = Vector2(size.x * 0.2, size.y * 0.13);
    final lampSize = Vector2(size.x * 0.12, size.y * 0.48);

    roger?.size = guardSize;
    newgate?.size = guardSize;

    doorAButton?.size = btnSize;
    doorBButton?.size = btnSize;

    roger?.position = Vector2(size.x * 0.84 - (newgate?.size.x ?? 0),
        size.y * 0.557 - (newgate?.size.y ?? 0) / 3);

    newgate?.position = Vector2(size.x * 0.29 - (roger?.size.x ?? 0),
        size.y * 0.557 - (roger?.size.y ?? 0) / 3);

    lampAnimation?.size = lampSize;
    lampAnimation?.position = Vector2(
        size.x * 0.43, size.y * 0.61 - (lampAnimation?.size.y ?? 0) / 3);

    _optionsSizing(size, btnSize);

    doorAButton?.position = Vector2(size.x * 0.14 - (newgate?.size.x ?? 0),
        (size.y * 0.5 - (viewNewgateIdComponent?.height ?? 0)));

    doorBButton?.position = Vector2(size.x * 0.70 - (roger?.size.x ?? 0),
        (size.y * 0.5 - (viewRogerIdComponent?.height ?? 0)));

    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size, Vector2 btnSize) {
    chatWithRogerComponent?.size = btnSize;
    chatWithNewgateComponent?.size = btnSize;

    viewNewgateIdComponent?.size = btnSize;
    viewRogerIdComponent?.size = btnSize;

    chatWithNewgateComponent?.position =
        Vector2(size.x * 0.14 - (roger?.size.x ?? 0 - 20), size.y * 0.5);

    chatWithRogerComponent?.position =
        Vector2(size.x * 0.68 - (newgate?.size.x ?? 0 - 20), size.y * 0.5);

    viewNewgateIdComponent?.position = Vector2(
        size.x * 0.14 - (roger?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewRogerIdComponent?.height ?? 0)));

    viewRogerIdComponent?.position = Vector2(
        size.x * 0.68 - (newgate?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewNewgateIdComponent?.height ?? 0)));
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.showOverlay(ChatScreen.overlayName);
  }

  Future _loadButtons() async {
    final chatWithRogerArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final chatWithNewgateArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final viewRogerIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final viewNewgateIdArtBoard =
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

    chatWithRogerComponent =
        RiveButtonComponent(chatWithRogerArtBoard, 'Chat with Roger', () {
      gameRef.guardIndex = 1;
      openChat();
      showOptions();
    });

    chatWithNewgateComponent =
        RiveButtonComponent(chatWithNewgateArtBoard, 'Chat with Newgate', () {
      gameRef.guardIndex = 0;
      openChat();
      showOptions();
    });

    viewNewgateIdComponent =
        RiveButtonComponent(viewNewgateIdArtBoard, 'View Newgate’s ID', () {
      gameRef.guardIndex = 0;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    viewRogerIdComponent =
        RiveButtonComponent(viewRogerIdArtBoard, 'View Roger’s ID', () {
      gameRef.guardIndex = 1;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    await addAll([
      viewNewgateIdComponent!,
      viewRogerIdComponent!,
      chatWithNewgateComponent!,
      chatWithRogerComponent!
    ]);
  }

  void showOptions() async {
    removeAll([
      viewNewgateIdComponent!,
      viewRogerIdComponent!,
      chatWithNewgateComponent!,
      chatWithRogerComponent!
    ]);
    await addAll([doorAButton!, doorBButton!]);
  }
}
