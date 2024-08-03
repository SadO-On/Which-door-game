import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_svg/flame_svg.dart';
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

  SvgComponent? doorA;
  SvgComponent? doorB;
  SvgComponent? doorC;
  GuardComponent? fred;
  RiveButtonComponent? viewFredIdComponent;
  RiveButtonComponent? chatWithFredIdComponent;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  RiveButtonComponent? doorCButton;
  SvgComponent? background;

  @override
  FutureOr<void> onLoad() async {
    final svgInstance = await Svg.load('images/background_level_two.svg');
    background = SvgComponent(
      size: gameRef.size,
      svg: svgInstance,
    );

    add(background!);
    add(MissionComponent(levels[gameRef.level.id]!.riddle));

    final sprite = await Svg.load('images/door_a.svg');
    final spriteB = await Svg.load('images/door_b.svg');
    final spriteC = await Svg.load('images/door_c.svg');

    final size = Vector2(130, 265);
    doorA = SvgComponent(size: size, svg: sprite);
    doorB = SvgComponent(size: size, svg: spriteB);
    doorC = SvgComponent(size: size, svg: spriteC);

    addAll([doorA!, doorB!, doorC!]);

    final fredArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/steve_idle_standing.riv')); //TODO change it
    fred = GuardComponent(artboard: fredArtBoard);
    add(fred!);
    await _loadButtons();
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
      gameRef.showOverlay(WinPopup.overlayName);
    });

    doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
      gameRef.showOverlay(LostPopup.overlayName);
    });

    doorCButton = RiveButtonComponent(cDoorArtBoard, 'Door C', () {
      gameRef.showOverlay(LostPopup.overlayName);
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
    doorA?.position =
        Vector2(size.x * 0.25, size.y * 0.557 - (doorA?.size.y ?? 0) / 2);
    doorB?.position =
        Vector2(size.x * 0.52, size.y * 0.557 - (doorB?.size.y ?? 0) / 2);
    doorC?.position =
        Vector2(size.x * 0.79, size.y * 0.557 - (doorC?.size.y ?? 0) / 2);
    fred?.position = Vector2(size.x * 0.28 - (fred?.size.x ?? 0 - 20),
        size.y * 0.557 - (fred?.size.y ?? 0) / 3);

    _optionsSizing(size);

    doorAButton?.position = Vector2(size.x * 0.14 - (fred?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));

    doorBButton?.position = Vector2(size.x * 0.47 - (fred?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));

    doorCButton?.position = Vector2(size.x * 0.74 - (fred?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));

    background?.size = size;
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size) {
    chatWithFredIdComponent?.position =
        Vector2(size.x * 0.14 - (fred?.size.x ?? 0 - 20), size.y * 0.5);

    viewFredIdComponent?.position = Vector2(
        size.x * 0.14 - (fred?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewFredIdComponent?.height ?? 0)));
  }
}
