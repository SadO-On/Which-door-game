import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:gaurds_game/game/components/mission_component.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../../data/model/level.dart';
import '../components/guard_id_popup.dart';
import '../components/lost_popup.dart';
import '../components/rive_button_component.dart';
import '../components/win_popup.dart';
import '../level01/components/guard_component.dart';

class GameLevelFour extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelFour({required this.level});

  final Level level;
  SvgComponent? doorA, doorB, doorC;
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
  SvgComponent? background;
  @override
  FutureOr<void> onLoad() async {
    final svgInstance = await Svg.load('images/background_level_four.svg');

    final backgroundSize = gameRef.size;

    background = SvgComponent(
      size: backgroundSize,
      svg: svgInstance,
    );
    addAll(
        [background!, MissionComponent(text: level.riddle, isWithClock: true)]);

    final sprite = await Svg.load('images/door_a.svg');
    final spriteB = await Svg.load('images/door_b.svg');
    final spriteC = await Svg.load('images/door_c.svg');

    final size = Vector2(130, 265);

    doorA = SvgComponent(size: size, svg: sprite);
    doorB = SvgComponent(size: size, svg: spriteB);
    doorC = SvgComponent(size: size, svg: spriteC);

    addAll([doorA!, doorB!, doorC!]);

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

    chatWithKaneComponent =
        RiveButtonComponent(chatWithFredArtBoard, 'Chat with Kane', () {
      gameRef.guardIndex = 2;
      openChat();
      showOptions();
    });

    viewKaneIdComponent =
        RiveButtonComponent(viewFredIdArtBoard, 'View kane’s ID', () {
      gameRef.guardIndex = 2;

      game.showOverlay(GuardIdPopup.overlayName);
    });

    chatWithMargaretComponent =
        RiveButtonComponent(chatWithFredArtBoard, 'Chat with Margaret', () {
      gameRef.guardIndex = 1;
      openChat();
      showOptions();
    });

    viewMargaretIdComponent =
        RiveButtonComponent(viewFredIdArtBoard, 'View margaret ID', () {
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
    ]);
    await addAll([doorAButton!, doorBButton!, doorCButton!]);
  }

  @override
  void onGameResize(Vector2 size) {
    margaret?.width = 100;
    margaret?.height = 210;
    doorA?.position =
        Vector2(size.x * 0.22, size.y * 0.557 - (doorA?.size.y ?? 0) / 2);
    doorB?.position =
        Vector2(size.x * 0.52, size.y * 0.557 - (doorB?.size.y ?? 0) / 2);
    doorC?.position =
        Vector2(size.x * 0.82, size.y * 0.557 - (doorC?.size.y ?? 0) / 2);

    fred?.position = Vector2(size.x * 0.27 - (fred?.size.x ?? 0 - 20),
        size.y * 0.557 - (fred?.size.y ?? 0) / 3);
    margaret?.position = Vector2(size.x * 0.56 - (margaret?.size.x ?? 0 - 20),
        size.y * 0.60 - (fred?.size.y ?? 0) / 3);
    kane?.position =
        Vector2(size.x * 0.77, size.y * 0.557 - (fred?.size.y ?? 0) / 3);

    doorAButton?.position =
        Vector2(size.x * 0.24 - (doorAButton?.size.x ?? 0) / 5, size.y * 0.30);
    doorBButton?.position =
        Vector2(size.x * 0.42 - (doorBButton?.size.x ?? 0) / 5, size.y * 0.30);
    doorCButton?.position =
        Vector2(size.x * 0.60 - (doorCButton?.size.x ?? 0) / 5, size.y * 0.30);
    _optionsSizing(size);
    background?.size = size;
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size) {
    chatWithFredComponent?.position =
        Vector2(size.x * 0.14 - (fred?.size.x ?? 0 - 20), size.y * 0.5);

    viewFredIdComponent?.position = Vector2(
        size.x * 0.14 - (fred?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));

    chatWithMargaretComponent?.position =
        Vector2(size.x * 0.45 - (margaret?.size.x ?? 0 - 20), size.y * 0.5);

    viewMargaretIdComponent?.position = Vector2(
        size.x * 0.45 - (margaret?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewMargaretIdComponent?.height ?? 0)));

    chatWithKaneComponent?.position =
        Vector2(size.x * 0.75 - (fred?.size.x ?? 0 - 20), size.y * 0.5);

    viewKaneIdComponent?.position = Vector2(
        size.x * 0.75 - (fred?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));
  }
}
