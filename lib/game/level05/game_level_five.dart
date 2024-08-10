import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/components/clock_component.dart';
import 'package:gaurds_game/game/level05/components/big_message_component.dart';
import 'package:gaurds_game/game/level05/components/message_component.dart';
import 'package:gaurds_game/game/level_interface.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../components/guard_id_popup.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../level01/components/guard_component.dart';
import '../level01/components/lamp_component.dart';

class GameLevelFive extends Component
    with HasGameRef<WhichDoorGameScreen>
    implements LevelInterface {
  GameLevelFive({required this.level});
  final Level level;
  SvgComponent? doorA;
  SvgComponent? doorB;
  GuardComponent? sam;
  RiveButtonComponent? viewSamIdComponent;
  RiveButtonComponent? chatWithSamComponent;
  RiveButtonComponent? readTheMessage;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  LampComponent? lampAnimation;
  SvgComponent? background;
  @override
  AudioPlayer? player;
  @override
  FutureOr<void> onLoad() async {
    final svgInstance = await Svg.load('images/background_level_5.svg');
    final backgroundSize = gameRef.size;
    background = SvgComponent(
      size: backgroundSize,
      svg: svgInstance,
    );

    await addAll(
        [background!, ClockComponent(), MissionComponent(text: level.riddle)]);

    final sprite = await Svg.load('images/door_a.svg');
    final spriteB = await Svg.load('images/door_b.svg');
    final size = Vector2(130, 265);

    doorA = SvgComponent(size: size, svg: sprite);
    doorB = SvgComponent(size: size, svg: spriteB);
    addAll([doorA!, doorB!, MessageComponent()]);
    final samArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/sam_idle_standing.riv'));
    sam = GuardComponent(artboard: samArtBoard);

    add(sam!);

    final lampArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/red_lamp.riv'));
    lampAnimation = LampComponent(artboard: lampArtBoard);
    add(lampAnimation!);
    await _loadButtons();
    player = await FlameAudio.play('clockSound-levelfive.mp3');
    return super.onLoad();
  }

  @override
  void onRemove() {
    player?.stop();
    player?.dispose();
    super.onRemove();
  }

  @override
  void onGameResize(Vector2 size) {
    doorA?.position =
        Vector2(size.x * 0.25, size.y * 0.557 - (doorA?.size.y ?? 0) / 2);
    doorB?.position =
        Vector2(size.x * 0.78, size.y * 0.557 - (doorB?.size.y ?? 0) / 2);
    sam?.position = Vector2(size.x * 0.28 - (sam?.size.x ?? 0 - 20),
        size.y * 0.557 - (sam?.size.y ?? 0) / 3);
    doorAButton?.position = Vector2(size.x * 0.04, size.y * 0.50);
    doorBButton?.position =
        Vector2(size.x * 0.63, (size.y * 0.62 - (readTheMessage?.height ?? 0)));
    lampAnimation?.position = Vector2(
        size.x * 0.49, size.y * 0.557 - (lampAnimation?.size.y ?? 0) / 3);
    _optionsSizing(size);
    background?.size = size;
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size) {
    chatWithSamComponent?.position =
        Vector2(size.x * 0.13 - (sam?.size.x ?? 0 - 20), size.y * 0.5);

    viewSamIdComponent?.position = Vector2(
        size.x * 0.13 - (sam?.size.x ?? 0 - 20),
        (size.y * 0.5 - (viewSamIdComponent?.height ?? 0)));
    readTheMessage?.position =
        Vector2(size.x * 0.63, (size.y * 0.53 - (readTheMessage?.height ?? 0)));
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
    final readMessageArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    doorAButton = RiveButtonComponent(aDoorArtBoard, 'Door A', () {
      // gameRef.playerWin();
    });

    doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
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

    readTheMessage =
        RiveButtonComponent(readMessageArtBoard, 'Read the door message', () {
      gameRef.showOverlay(BigMessageComponent.overlayName);
    });

    await addAll([viewSamIdComponent!, chatWithSamComponent!, readTheMessage!]);
  }

  void showOptions() async {
    removeAll([
      viewSamIdComponent!,
      chatWithSamComponent!,
    ]);
    await addAll([doorAButton!, doorBButton!]);
  }
}
