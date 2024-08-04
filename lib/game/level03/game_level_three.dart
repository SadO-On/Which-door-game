import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:gaurds_game/game/components/guard_id_popup.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../../data/model/level.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../level01/components/guard_component.dart';

class GameLevelThree extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelThree({required this.level});

  final Level level;
  SvgComponent? doorA;
  SvgComponent? doorB;
  SvgComponent? doorC;
  SvgComponent? doorD;
  GuardComponent? sam;
  RiveButtonComponent? viewSamIdComponent;
  RiveButtonComponent? chatWithSamComponent;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  RiveButtonComponent? doorCButton;
  RiveButtonComponent? doorDButton;

  @override
  FutureOr<void> onLoad() async {
    final svgInstance = await Svg.load('images/background_4_doors.svg');
    final backgroundSize = gameRef.size;

    final background = SvgComponent(
      size: backgroundSize,
      svg: svgInstance,
    );

    add(background);

    add(MissionComponent(
        'The guard, Sam, is hesitant to speak. You must give him a compelling reason to talk and reveal the correct door.'));

    final sprite = await Svg.load('images/door_a.svg');
    final spriteB = await Svg.load('images/door_b.svg');
    final spriteC = await Svg.load('images/door_c.svg');
    final spriteD = await Svg.load('images/door_d.svg');

    final size = Vector2(97, 195);

    doorA = SvgComponent(size: size, svg: sprite);
    doorB = SvgComponent(size: size, svg: spriteB);
    doorC = SvgComponent(size: size, svg: spriteC);
    doorD = SvgComponent(size: size, svg: spriteD);

    addAll([doorA!, doorB!, doorC!, doorD!]);

    final samArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/steve_idle_standing.riv'));
    sam = GuardComponent(artboard: samArtBoard);

    add(sam!);

    await _loadButtons();
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    //TODO make the size dynamic
    sam?.width = 83;
    sam?.height = 180;
    doorA?.position =
        Vector2(size.x * 0.24, size.y * 0.557 - (doorA?.size.y ?? 0) / 3);
    doorB?.position =
        Vector2(size.x * 0.42, size.y * 0.557 - (doorB?.size.y ?? 0) / 3);
    doorC?.position =
        Vector2(size.x * 0.60, size.y * 0.557 - (doorC?.size.y ?? 0) / 3);
    doorD?.position =
        Vector2(size.x * 0.78, size.y * 0.557 - (doorC?.size.y ?? 0) / 3);
    sam?.position = Vector2(size.x * 0.26 - (sam?.size.x ?? 0 - 20),
        size.y * 0.557 - (sam?.size.y ?? 0) / 4);

    doorAButton?.position =
        Vector2(size.x * 0.24 - (doorAButton?.size.x ?? 0) / 5, size.y * 0.30);
    doorBButton?.position =
        Vector2(size.x * 0.42 - (doorBButton?.size.x ?? 0) / 5, size.y * 0.30);
    doorCButton?.position =
        Vector2(size.x * 0.60 - (doorCButton?.size.x ?? 0) / 5, size.y * 0.30);
    doorDButton?.position =
        Vector2(size.x * 0.78 - (doorDButton?.size.x ?? 0) / 5, size.y * 0.30);
    _optionsSizing(size);
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size) {
    chatWithSamComponent?.position =
        Vector2(size.x * 0.13 - (sam?.size.x ?? 0 - 20), size.y * 0.5);

    viewSamIdComponent?.position = Vector2(
        size.x * 0.13 - (sam?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewSamIdComponent?.height ?? 0)));
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.overlays.add(ChatScreen.overlayName);
  }

  Future _loadButtons() async {
    final chatWithSamArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewSamIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final cDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final dDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    doorAButton = RiveButtonComponent(aDoorArtBoard, 'Door A', () {
      // gameRef.playerWin();
    });

    doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
      // gameRef.playerLost();
    });

    doorCButton = RiveButtonComponent(cDoorArtBoard, 'Door C', () {
      // gameRef.playerLost();
    });

    doorDButton = RiveButtonComponent(dDoorArtBoard, 'Door D', () {
      // gameRef.playerLost();
    });

    chatWithSamComponent =
        RiveButtonComponent(chatWithSamArtBoard, 'Chat with Sam', () {
      gameRef.guardIndex = 0;
      openChat();
      showOptions();
    });

    viewSamIdComponent =
        RiveButtonComponent(viewSamIdArtBoard, 'View Sam’s ID', () {
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
