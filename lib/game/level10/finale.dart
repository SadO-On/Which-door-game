import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../../data/model/level.dart';
import '../components/guard_id_popup.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../level01/components/guard_component.dart';
import '../level01/components/lamp_component.dart';

class Finale extends Component with HasGameRef<WhichDoorGameScreen> {
  Finale({required this.level});
  final Level level;

  SvgComponent? doorA, doorB;
  GuardComponent? roger, newgate;
  RiveButtonComponent? viewNewgateIdComponent,
      viewRogerIdComponent,
      chatWithNewgateComponent,
      chatWithRogerComponent;
  RiveButtonComponent? doorAButton, doorBButton;
  LampComponent? lampAnimation;
  SvgComponent? background;

  @override
  FutureOr<void> onLoad() async {
    final svgInstance = await Svg.load('images/background_finale.svg');

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

    final newgateArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/steve_idle_standing.riv')); //TODO
    newgate = GuardComponent(artboard: newgateArtBoard);
    final rogerArtBoard = await loadArtboard(
        RiveFile.asset('assets/rive/willy_idle_standing.riv')); //TODO
    roger = GuardComponent(artboard: rogerArtBoard);
    addAll([roger!, newgate!]);

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

    roger?.position = Vector2(size.x * 0.28 - (roger?.size.x ?? 0 - 20),
        size.y * 0.557 - (roger?.size.y ?? 0) / 3);

    newgate?.position = Vector2(size.x * 0.81 - (newgate?.size.x ?? 0 - 20),
        size.y * 0.557 - (newgate?.size.y ?? 0) / 3);

    lampAnimation?.position = Vector2(
        size.x * 0.49, size.y * 0.557 - (lampAnimation?.size.y ?? 0) / 3);

    _optionsSizing(size);

    doorAButton?.position = Vector2(size.x * 0.14 - (newgate?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewNewgateIdComponent?.height ?? 0)));

    doorBButton?.position = Vector2(size.x * 0.68 - (roger?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewRogerIdComponent?.height ?? 0)));

    background?.size = size;
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size) {
    chatWithRogerComponent?.position =
        Vector2(size.x * 0.14 - (roger?.size.x ?? 0 - 20), size.y * 0.5);

    chatWithNewgateComponent?.position =
        Vector2(size.x * 0.68 - (newgate?.size.x ?? 0 - 20), size.y * 0.5);

    viewNewgateIdComponent?.position = Vector2(
        size.x * 0.68 - (newgate?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewNewgateIdComponent?.height ?? 0)));

    viewRogerIdComponent?.position = Vector2(
        size.x * 0.14 - (roger?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewRogerIdComponent?.height ?? 0)));
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.showOverlay(ChatScreen.overlayName);
  }

  Future _loadButtons() async {
    final chatWithRogerArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final chatWithNewgateArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewRogerIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final viewNewgateIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    doorAButton = RiveButtonComponent(aDoorArtBoard, 'Door A', () {
      //TODO special ending
    });

    doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
      //TODO special losing
    });

    chatWithRogerComponent =
        RiveButtonComponent(chatWithRogerArtBoard, 'Chat with Willy', () {
      gameRef.guardIndex = 1;
      openChat();
      showOptions();
    });

    chatWithNewgateComponent =
        RiveButtonComponent(chatWithNewgateArtBoard, 'Chat with Steve', () {
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
