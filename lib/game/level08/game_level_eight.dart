import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:gaurds_game/game/components/clock_game_component.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../../data/model/level.dart';
import '../components/guard_id_popup.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../level01/components/guard_component.dart';

class GameLevelEight extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelEight({required this.level});

  final Level level;
  GuardComponent? fred;

  RiveButtonComponent? viewFredIdComponent,
      chatWithFredComponent,
      fixClockButton;

  @override
  FutureOr<void> onLoad() async {
    add(MissionComponent(text: level.riddle, m: gameRef.size.y * 0.5));
    final fredArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/guard_fred_idle_standing.riv'));
    fred = GuardComponent(artboard: fredArtBoard);
    add(fred!);
    add(ClockGameComponent());
    await _loadButtons();
    return super.onLoad();
  }

  Future _loadButtons() async {
    final fixClockArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    fixClockButton = RiveButtonComponent(fixClockArtBoard, 'Fix clock', () {});

    final chatWithFredArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final viewFredIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));

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

    add(fixClockButton!);
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.overlays.add(ChatScreen.overlayName);
  }

  void showOptions() async {
    removeAll([
      chatWithFredComponent!,
      viewFredIdComponent!,
    ]);
    await add(fixClockButton!);
  }

  @override
  void onGameResize(Vector2 size) {
    final guardSize = Vector2(size.x * 0.16, size.y * 0.65);
    final btnSize = Vector2(size.x * 0.2, size.y * 0.13);

    fred?.size = guardSize;
    fred?.position = Vector2(size.x * 0.32, size.y * 0.3);

    fixClockButton?.size = btnSize;
    fixClockButton?.position = Vector2(size.x * 0.6, size.y * 0.4);
    _optionsSizing(size, btnSize);
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size, Vector2 btnSize) {
    chatWithFredComponent?.size = btnSize;
    viewFredIdComponent?.size = btnSize;

    chatWithFredComponent?.position =
        Vector2(size.x * 0.135 - (fred?.size.x ?? 0), size.y * 0.5);

    viewFredIdComponent?.position = Vector2(
        size.x * 0.135 - (fred?.size.x ?? 0),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));
  }
}
