import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_svg/flame_svg.dart';
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
  SvgComponent? doorA;
  SvgComponent? doorB;
  GuardComponent? willy;
  GuardComponent? steve;
  RiveButtonComponent? viewWillyIdComponent;
  RiveButtonComponent? viewSteveIdComponent;
  RiveButtonComponent? chatWithSteveComponent;
  RiveButtonComponent? chatWithWillyComponent;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  LampComponent? lampAnimation;
  SvgComponent? background;

  @override
  FutureOr<void> onLoad() async {
    final svgInstance = await Svg.load('images/background_2_doors.svg');

    background = SvgComponent(
      size: gameRef.size,
      svg: svgInstance,
    );

    addAll([background!, MissionComponent(text: level.riddle)]);
    final sprite = await Svg.load('images/door_a.svg');
    final spriteB = await Svg.load('images/door_b.svg');

    final size = Vector2(130, 265);
    doorA = SvgComponent(size: size, svg: sprite);
    doorB = SvgComponent(size: size, svg: spriteB);
    addAll([doorA!, doorB!]);

    final steveArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/steve_idle_standing.riv'));
    steve = GuardComponent(artboard: steveArtBoard);
    add(steve!);

    final willyArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/willy_idle_standing.riv'));
    willy = GuardComponent(artboard: willyArtBoard);
    add(willy!);

    final lampArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/lamp_animation.riv'));
    lampAnimation = LampComponent(artboard: lampArtBoard);
    add(lampAnimation!);
    await _loadButtons();
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    doorA?.position =
        Vector2(size.x * 0.25, size.y * 0.557 - (doorA?.size.y ?? 0) / 2);
    doorB?.position =
        Vector2(size.x * 0.78, size.y * 0.557 - (doorB?.size.y ?? 0) / 2);

    willy?.position = Vector2(size.x * 0.28 - (willy?.size.x ?? 0 - 20),
        size.y * 0.557 - (willy?.size.y ?? 0) / 3);

    steve?.position = Vector2(size.x * 0.81 - (steve?.size.x ?? 0 - 20),
        size.y * 0.557 - (steve?.size.y ?? 0) / 3);

    lampAnimation?.position = Vector2(
        size.x * 0.49, size.y * 0.557 - (lampAnimation?.size.y ?? 0) / 3);

    _optionsSizing(size);

    doorAButton?.position = Vector2(size.x * 0.14 - (steve?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewWillyIdComponent?.height ?? 0)));

    doorBButton?.position = Vector2(size.x * 0.68 - (willy?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewSteveIdComponent?.height ?? 0)));

    background?.size = size;
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size) {
    chatWithWillyComponent?.position =
        Vector2(size.x * 0.14 - (willy?.size.x ?? 0 - 20), size.y * 0.5);

    chatWithSteveComponent?.position =
        Vector2(size.x * 0.68 - (steve?.size.x ?? 0 - 20), size.y * 0.5);

    viewSteveIdComponent?.position = Vector2(
        size.x * 0.68 - (steve?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewWillyIdComponent?.height ?? 0)));

    viewWillyIdComponent?.position = Vector2(
        size.x * 0.14 - (willy?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewSteveIdComponent?.height ?? 0)));
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.showOverlay(ChatScreen.overlayName);
  }

  Future _loadButtons() async {
    final chatWithWillyArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final chatWithSteveArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewWillyIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewSteveIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final bDoorArtBoard =
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
