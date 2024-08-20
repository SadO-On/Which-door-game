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

class GameLevelSeven extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelSeven({required this.level});

  final Level level;

  GuardComponent? fred;
  GuardComponent? willy;
  GuardComponent? sam;

  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  RiveButtonComponent? doorCButton;
  RiveButtonComponent? viewFredIdComponent;
  RiveButtonComponent? chatWithFredComponent;
  RiveButtonComponent? viewSamIdComponent;
  RiveButtonComponent? chatWithSamComponent;
  RiveButtonComponent? viewWillyIdComponent;
  RiveButtonComponent? chatWithWillyComponent;

  @override
  FutureOr<void> onLoad() async {
    add(MissionComponent(text: level.riddle));

    final fredArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/guard_fred_idle_standing.riv'));
    final samArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/sam_idle_standing.riv'));
    final willyArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/willy_idle_standing.riv'));
    fred = GuardComponent(artboard: fredArtBoard);
    sam = GuardComponent(artboard: samArtBoard);

    willy = GuardComponent(artboard: willyArtBoard);
    await _loadButtons();
    await addAll([fred!, willy!, sam!]);

    return super.onLoad();
  }

  Future _loadButtons() async {
    final chatWithFredArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewFredIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final cDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    doorAButton = RiveButtonComponent(aDoorArtBoard, 'Door A', () {
      gameRef.showOverlay(LostPopup.overlayName);
    });

    doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
      gameRef.showOverlay(WinPopup.overlayName);
    });

    doorCButton = RiveButtonComponent(cDoorArtBoard, 'Door C', () {
      gameRef.showOverlay(LostPopup.overlayName);
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

    chatWithWillyComponent =
        RiveButtonComponent(chatWithFredArtBoard, 'Chat with Willy', () {
      gameRef.guardIndex = 2;
      openChat();
      showOptions();
    });

    viewWillyIdComponent =
        RiveButtonComponent(viewFredIdArtBoard, 'View Willy’s ID', () {
      gameRef.guardIndex = 2;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    chatWithSamComponent =
        RiveButtonComponent(chatWithFredArtBoard, 'Chat with Sam', () {
      gameRef.guardIndex = 1;
      openChat();
      showOptions();
    });

    viewSamIdComponent =
        RiveButtonComponent(viewFredIdArtBoard, 'View Sam ID', () {
      gameRef.guardIndex = 1;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    await addAll([
      viewFredIdComponent!,
      viewSamIdComponent!,
      viewWillyIdComponent!,
      chatWithFredComponent!,
      chatWithSamComponent!,
      chatWithWillyComponent!,
    ]);
  }

  void showOptions() async {
    removeAll([
      chatWithFredComponent!,
      chatWithSamComponent!,
      chatWithWillyComponent!,
      viewFredIdComponent!,
      viewSamIdComponent!,
      viewWillyIdComponent!
    ]);
    await addAll([doorAButton!, doorBButton!, doorCButton!]);
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.showOverlay(ChatScreen.overlayName);
  }

  @override
  void onGameResize(Vector2 size) {
    final guardSize = Vector2(size.x * 0.10, size.y * 0.48);
    final btnSize = Vector2(size.x * 0.17, size.y * 0.10);

    sam?.size = guardSize;
    fred?.size = guardSize;
    willy?.size = guardSize;

    fred?.position = Vector2(size.x * 0.26 - (fred?.size.x ?? 0),
        size.y * 0.6 - (fred?.size.y ?? 0) / 3);

    sam?.position = Vector2(size.x * 0.5 - (sam?.size.x ?? 0),
        size.y * 0.6 - (fred?.size.y ?? 0) / 3);

    willy?.position =
        Vector2(size.x * 0.65, size.y * 0.6 - (fred?.size.y ?? 0) / 3);

    doorAButton?.size = btnSize;
    doorBButton?.size = btnSize;
    doorCButton?.size = btnSize;

    doorAButton?.position = Vector2(size.x * 0.28 - (fred?.size.x ?? 0),
        (size.y * 0.4 - (viewFredIdComponent?.height ?? 0)));
    doorBButton?.position = Vector2(size.x * 0.515 - (fred?.size.x ?? 0),
        (size.y * 0.4 - (viewFredIdComponent?.height ?? 0)));
    doorCButton?.position = Vector2(size.x * 0.765 - (fred?.size.x ?? 0),
        (size.y * 0.4 - (viewFredIdComponent?.height ?? 0)));
    _optionsSizing(size, btnSize);

    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size, Vector2 btnSize) {
    chatWithFredComponent?.size = btnSize;
    viewFredIdComponent?.size = btnSize;
    chatWithSamComponent?.size = btnSize;
    viewSamIdComponent?.size = btnSize;
    chatWithWillyComponent?.size = btnSize;
    viewWillyIdComponent?.size = btnSize;
    chatWithFredComponent?.position =
        Vector2(size.x * 0.14 - (fred?.size.x ?? 0), size.y * 0.5);

    viewFredIdComponent?.position = Vector2(size.x * 0.14 - (fred?.size.x ?? 0),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));

    chatWithSamComponent?.position =
        Vector2(size.x * 0.39 - (sam?.size.x ?? 0), size.y * 0.5);

    viewSamIdComponent?.position = Vector2(size.x * 0.39 - (fred?.size.x ?? 0),
        (size.y * 0.5 - (viewSamIdComponent?.height ?? 0)));

    chatWithWillyComponent?.position =
        Vector2(size.x * 0.64 - (fred?.size.x ?? 0), size.y * 0.5);

    viewWillyIdComponent?.position = Vector2(
        size.x * 0.64 - (fred?.size.x ?? 0),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));
  }
}
