import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:gaurds_game/game/components/lost_popup.dart';
import 'package:gaurds_game/game/components/win_popup.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../../data/model/level.dart';
import '../components/guard_id_popup.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../level01/components/guard_component.dart';

class GameLevelTwo extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelTwo({required this.level});
  final Level level;
  GuardComponent? fred;
  RiveButtonComponent? viewFredIdComponent;
  RiveButtonComponent? chatWithFredIdComponent;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  RiveButtonComponent? doorCButton;

  @override
  FutureOr<void> onLoad() async {
    add(MissionComponent(text: level.riddle));

    final fredArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/guard_fred_idle_standing.riv'));
    fred = GuardComponent(artboard: fredArtBoard);
    add(fred!);
    await _loadButtons();
    return super.onLoad();
  }

  Future _loadButtons() async {
    final chatWithFredArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final viewFredIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));

    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final cDoorArtBoard =
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

    chatWithFredIdComponent =
        RiveButtonComponent(chatWithFredArtBoard, 'Chat with Fred', () {
      gameRef.guardIndex = 0;
      openChat();
      showOptions();
    });

    viewFredIdComponent =
        RiveButtonComponent(viewFredIdArtBoard, 'View Fred’s ID', () {
      gameRef.guardIndex = 0;
      game.showOverlay(GuardIdPopup.overlayName);
    });

    await addAll([
      chatWithFredIdComponent!,
      viewFredIdComponent!,
    ]);
  }

  void showOptions() async {
    removeAll([
      chatWithFredIdComponent!,
      viewFredIdComponent!,
    ]);
    await addAll([doorAButton!, doorBButton!, doorCButton!]);
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.showOverlay(ChatScreen.overlayName);
  }

  @override
  void onGameResize(Vector2 size) {
    final guardSize = Vector2(size.x * 0.11, size.y * 0.53);
    final btnSize = Vector2(size.x * 0.16, size.y * 0.1);

    fred?.size = guardSize;
    fred?.position = Vector2(size.x * 0.28 - (fred?.size.x ?? 0),
        size.y * 0.56 - (fred?.size.y ?? 0) / 3);

    _optionsSizing(size);

    doorAButton?.size = btnSize;
    doorBButton?.size = btnSize;
    doorCButton?.size = btnSize;

    doorAButton?.position = Vector2(size.x * 0.04, size.y * 0.5);

    doorBButton?.position = Vector2(size.x * 0.365, size.y * 0.5);

    doorCButton?.position = Vector2(size.x * 0.62, size.y * 0.5);

    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size) {
    chatWithFredIdComponent?.position = Vector2(
        size.x * 0.22 - (chatWithFredIdComponent?.size.x ?? 0), size.y * 0.5);

    viewFredIdComponent?.position = Vector2(
        size.x * 0.22 - (viewFredIdComponent?.size.x ?? 0),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));
  }
}
