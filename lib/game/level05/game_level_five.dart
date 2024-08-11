import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/components/clock_component.dart';
import 'package:gaurds_game/game/level05/components/big_message_component.dart';
import 'package:gaurds_game/game/level05/components/message_component.dart';
import 'package:gaurds_game/game/level_interface.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../chat/chat_screen.dart';
import '../components/guard_id_popup.dart';
import '../components/lost_popup.dart';
import '../components/mission_component.dart';
import '../components/rive_button_component.dart';
import '../components/win_popup.dart';
import '../level01/components/guard_component.dart';
import '../level01/components/lamp_component.dart';

class GameLevelFive extends Component
    with HasGameRef<WhichDoorGameScreen>
    implements LevelInterface {
  GameLevelFive({required this.level});
  final Level level;

  GuardComponent? sam;
  RiveButtonComponent? viewSamIdComponent;
  RiveButtonComponent? chatWithSamComponent;
  RiveButtonComponent? readTheMessage;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  LampComponent? lampAnimation;

  @override
  AudioPlayer? player;
  @override
  FutureOr<void> onLoad() async {
    await addAll([
      ClockComponent(),
      MissionComponent(text: level.riddle),
      MessageComponent()
    ]);
    final samArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/sam_idle_standing.riv'));
    sam = GuardComponent(artboard: samArtBoard);

    final lampArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/red_lamp.riv'));
    lampAnimation = LampComponent(artboard: lampArtBoard);
    add(lampAnimation!);
    await _loadButtons();
    add(sam!);

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
    final guardSize = Vector2(size.x * 0.11, size.y * 0.53);
    final btnSize = Vector2(size.x * 0.2, size.y * 0.13);
    final lampSize = Vector2(size.x * 0.12, size.y * 0.48);

    sam?.size = guardSize;
    sam?.position = Vector2(size.x * 0.28 - (sam?.size.x ?? 0 - 20),
        size.y * 0.557 - (sam?.size.y ?? 0) / 3);

    doorAButton?.size = btnSize;
    doorBButton?.size = btnSize;

    lampAnimation?.size = lampSize;

    doorAButton?.position =
        Vector2(size.x * 0.135 - (sam?.size.x ?? 0), size.y * 0.50);
    doorBButton?.position = Vector2(size.x * 0.60, size.y * 0.5);
    lampAnimation?.position = Vector2(
        size.x * 0.49, size.y * 0.557 - (lampAnimation?.size.y ?? 0) / 3);
    _optionsSizing(size, btnSize);
    super.onGameResize(size);
  }

  void _optionsSizing(Vector2 size, Vector2 btnSize) {
    chatWithSamComponent?.size = btnSize;
    viewSamIdComponent?.size = btnSize;
    readTheMessage?.size = btnSize;

    chatWithSamComponent?.position =
        Vector2(size.x * 0.135 - (sam?.size.x ?? 0), size.y * 0.5);

    viewSamIdComponent?.position = Vector2(size.x * 0.135 - (sam?.size.x ?? 0),
        (size.y * 0.53 - (viewSamIdComponent?.height ?? 0)));
    readTheMessage?.position =
        Vector2(size.x * 0.60, (size.y * 0.53 - (readTheMessage?.height ?? 0)));
  }

  void openChat() async {
    await Flame.device.setPortrait();
    gameRef.overlays.add(ChatScreen.overlayName);
  }

  Future _loadButtons() async {
    final chatWithSamArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final viewSamIdArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final readMessageArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));

    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final bDoorArtBoard =
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
    removeAll([viewSamIdComponent!, chatWithSamComponent!, readTheMessage!]);
    await addAll([doorAButton!, doorBButton!]);
  }
}
