import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';

import '../../chat/chat_screen.dart';
import '../../data/model/level.dart';
import '../components/guard_id_popup.dart';
import '../components/lost_popup.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../components/win_popup.dart';
import '../level01/components/guard_component.dart';
import '../which_door_game_screen.dart';

class GameLevelFour extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelFour({required this.level});

  final Level level;
  GuardComponent? margaret, fred, kane;
  RiveButtonComponent? viewMargaretIdComponent,
      chatWithMargaretComponent,
      viewFredIdComponent,
      chatWithFredComponent,
      viewKaneIdComponent,
      chatWithKaneComponent,
      doorAButton,
      doorBButton,
      doorCButton;
  @override
  FutureOr<void> onLoad() async {
    add(MissionComponent(
        text: level.riddle, isWithClock: true, m: gameRef.size.y * 0.5));
    final margaretArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/margaret_idle_standing.riv'));
    margaret = GuardComponent(artboard: margaretArtBoard);

    final fredArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/guard_fred_idle_standing.riv'));
    fred = GuardComponent(artboard: fredArtBoard);

    final kaneArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/kane_idle_standing.riv'));
    kane = GuardComponent(artboard: kaneArtBoard);
    await _loadButtons();

    addAll([margaret!, fred!, kane!]);

    return super.onLoad();
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.overlays.add(ChatScreen.overlayName);
  }

  Future _loadButtons() async {
    final chatWithFredArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewFredIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    final chatWithMargaretArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewMargaretIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    final chatWithKaneArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewKaneIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final cDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

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

    chatWithFredComponent =
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

    chatWithKaneComponent =
        RiveButtonComponent(chatWithKaneArtBoard, 'Chat with Kane', () {
      gameRef.guardIndex = 2;
      openChat();
      showOptions();
    });

    viewKaneIdComponent =
        RiveButtonComponent(viewKaneIdArtBoard, 'View kane’s ID', () {
      gameRef.guardIndex = 2;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    chatWithMargaretComponent =
        RiveButtonComponent(chatWithMargaretArtBoard, 'Chat with Margaret', () {
      gameRef.guardIndex = 1;
      openChat();
      showOptions();
    });

    viewMargaretIdComponent =
        RiveButtonComponent(viewMargaretIdArtBoard, 'View margaret ID', () {
      gameRef.guardIndex = 1;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    await addAll([
      viewFredIdComponent!,
      viewMargaretIdComponent!,
      viewKaneIdComponent!,
      chatWithFredComponent!,
      chatWithMargaretComponent!,
      chatWithKaneComponent!,
    ]);
  }

  void showOptions() async {
    removeAll([
      chatWithFredComponent!,
      viewFredIdComponent!,
      viewMargaretIdComponent!,
      viewKaneIdComponent!,
      chatWithMargaretComponent!,
      chatWithKaneComponent!,
    ]);
    await addAll([doorAButton!, doorBButton!, doorCButton!]);
  }

  @override
  void onGameResize(Vector2 size) {
    final guardSize = Vector2(size.x * 0.11, size.y * 0.53);
    final btnSize = Vector2(size.x * 0.18, size.y * 0.11);

    margaret?.size = guardSize;
    fred?.size = guardSize;
    kane?.size = guardSize;

    fred?.position = Vector2(size.x * 0.27 - (fred?.size.x ?? 0 - 20),
        size.y * 0.557 - (fred?.size.y ?? 0) / 3);
    margaret?.position = Vector2(size.x * 0.56 - (margaret?.size.x ?? 0 - 20),
        size.y * 0.60 - (fred?.size.y ?? 0) / 3);
    kane?.position =
        Vector2(size.x * 0.77, size.y * 0.557 - (fred?.size.y ?? 0) / 3);

    doorAButton?.size = btnSize;
    doorBButton?.size = btnSize;
    doorCButton?.size = btnSize;

    doorAButton?.position = Vector2(size.x * 0.16, size.y * 0.22);
    doorBButton?.position = Vector2(size.x * 0.455, size.y * 0.22);
    doorCButton?.position = Vector2(size.x * 0.76, size.y * 0.22);
    _optionsSizing(size, btnSize);
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size, Vector2 btnSize) {
    chatWithFredComponent?.size = btnSize;
    viewFredIdComponent?.size = btnSize;
    chatWithMargaretComponent?.size = btnSize;
    viewMargaretIdComponent?.size = btnSize;
    viewKaneIdComponent?.size = btnSize;
    chatWithKaneComponent?.size = btnSize;

    chatWithFredComponent?.position =
        Vector2(size.x * 0.135 - (fred?.size.x ?? 0), size.y * 0.5);

    viewFredIdComponent?.position = Vector2(
        size.x * 0.135 - (fred?.size.x ?? 0),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));

    chatWithMargaretComponent?.position =
        Vector2(size.x * 0.44 - (margaret?.size.x ?? 0), size.y * 0.5);

    viewMargaretIdComponent?.position = Vector2(
        size.x * 0.44 - (margaret?.size.x ?? 0),
        (size.y * 0.5 - (viewMargaretIdComponent?.height ?? 0)));

    chatWithKaneComponent?.position =
        Vector2(size.x * 0.74 - (fred?.size.x ?? 0), size.y * 0.5);

    viewKaneIdComponent?.position = Vector2(size.x * 0.74 - (fred?.size.x ?? 0),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));
  }
}
