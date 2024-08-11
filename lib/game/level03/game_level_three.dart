import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:gaurds_game/game/components/guard_id_popup.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../../data/model/level.dart';
import '../components/lost_popup.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../components/win_popup.dart';
import '../level01/components/guard_component.dart';

class GameLevelThree extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelThree({required this.level});

  final Level level;
  GuardComponent? margaret;
  RiveButtonComponent? viewSamIdComponent;
  RiveButtonComponent? chatWithSamComponent;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  RiveButtonComponent? doorCButton;
  RiveButtonComponent? doorDButton;
  @override
  FutureOr<void> onLoad() async {
    add(MissionComponent(
        text: level.riddle, isWithClock: true, m: gameRef.size.y * 0.5));
    final margaretArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/margaret_idle_standing.riv'));
    margaret = GuardComponent(artboard: margaretArtBoard);
    add(margaret!);
    await _loadButtons();
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    final guardSize = Vector2(size.x * 0.08, size.y * 0.46);
    final btnSize = Vector2(size.x * 0.19, size.y * 0.1);
    doorAButton?.size = btnSize;
    doorBButton?.size = btnSize;
    doorCButton?.size = btnSize;
    doorDButton?.size = btnSize;
    chatWithSamComponent?.size = btnSize;
    viewSamIdComponent?.size = btnSize;
    margaret?.size = guardSize;
    margaret?.position =
        Vector2(size.x * 0.26 - (margaret?.size.x ?? 0), size.y * 0.48);
    doorAButton?.position = Vector2(size.x * 0.11, size.y * 0.30);
    doorBButton?.position = Vector2(size.x * 0.34, size.y * 0.30);
    doorCButton?.position = Vector2(size.x * 0.59, size.y * 0.30);
    doorDButton?.position = Vector2(size.x * 0.83, size.y * 0.30);
    _optionsSizing(size);

    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size) {
    chatWithSamComponent?.position = Vector2(size.x * 0.216, size.y * 0.5);

    viewSamIdComponent?.position = Vector2(
        size.x * 0.216, (size.y * 0.5 - (viewSamIdComponent?.height ?? 0)));
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.overlays.add(ChatScreen.overlayName);
  }

  Future _loadButtons() async {
    final chatWithSamArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final viewSamIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));

    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final cDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final dDoorArtBoard =
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

    doorCButton = RiveButtonComponent(cDoorArtBoard, 'Door C', () {
      if (level.correctDoor == "C") {
        gameRef.showOverlay(WinPopup.overlayName);
      } else {
        gameRef.showOverlay(LostPopup.overlayName);
      }
    });

    doorDButton = RiveButtonComponent(dDoorArtBoard, 'Door D', () {
      if (level.correctDoor == "D") {
        gameRef.showOverlay(WinPopup.overlayName);
      } else {
        gameRef.showOverlay(LostPopup.overlayName);
      }
    });

    chatWithSamComponent =
        RiveButtonComponent(chatWithSamArtBoard, 'Chat with Margaret', () {
      gameRef.guardIndex = 0;
      openChat();
      showOptions();
    });

    viewSamIdComponent =
        RiveButtonComponent(viewSamIdArtBoard, 'View Margaret ID', () {
      gameRef.guardIndex = 0;
      gameRef.showOverlay(GuardIdPopup.overlayName);
    });

    await addAll([
      viewSamIdComponent!,
      chatWithSamComponent!,
    ]);
  }

  void showOptions() async {
    removeAll([
      viewSamIdComponent!,
      chatWithSamComponent!,
    ]);
    await addAll([doorAButton!, doorBButton!, doorCButton!, doorDButton!]);
  }
}
