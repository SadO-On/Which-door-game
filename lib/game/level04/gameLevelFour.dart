import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:gaurds_game/game/components/mission_component.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../data/model/level.dart';
import '../components/rive_button_component.dart';
import '../level01/components/guard_component.dart';

class GameLevelFour extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelFour({required this.level});

  final Level level;
  // SvgComponent? doorA;
  // SvgComponent? doorB;
  // SvgComponent? doorC;
  // SvgComponent? doorD;
  // GuardComponent? sam;
  // RiveButtonComponent? viewSamIdComponent;
  // RiveButtonComponent? chatWithSamComponent;
  // // RiveButtonComponent? doorAButton;
  // // RiveButtonComponent? doorBButton;

  // @override
  // FutureOr<void> onLoad() async {
  //   final svgInstance = await Svg.load('images/background_4_doors.svg');
  //   final backgroundSize = gameRef.size;

  //   final background = SvgComponent(
  //     size: backgroundSize,
  //     svg: svgInstance,
  //   );

  //   add(background);

  //   add(MissionComponent(
  //       'The guard, Sam, is hesitant to speak. You must give him a compelling reason to talk and reveal the correct door.'));

  //   final sprite = await Svg.load('images/door_a.svg');
  //   final spriteB = await Svg.load('images/door_b.svg');
  //   final spriteC = await Svg.load('images/door_c.svg');
  //   final spriteD = await Svg.load('images/door_d.svg');

  //   final size = Vector2(130, 265);

  //   doorA = SvgComponent(size: size, svg: sprite);
  //   doorB = SvgComponent(size: size, svg: spriteB);
  //   doorC = SvgComponent(size: size, svg: spriteC);
  //   doorD = SvgComponent(size: size, svg: spriteD);

  //   addAll([doorA!, doorB!, doorC!, doorD!]);

  //   final samArtBoard = await loadArtboard(
  //       RiveFile.asset('assets/rive/steve_idle_standing.riv'));
  //   sam = GuardComponent(artboard: samArtBoard);
  //   add(sam!);

  //   await _loadButtons();
  //   return super.onLoad();
  // }

  // @override
  // void onGameResize(Vector2 size) {
  //   doorA?.position =
  //       Vector2(size.x * 0.23, size.y * 0.557 - (doorA?.size.y ?? 0) / 2);
  //   doorB?.position =
  //       Vector2(size.x * 0.41, size.y * 0.557 - (doorB?.size.y ?? 0) / 2);
  //   doorC?.position =
  //       Vector2(size.x * 0.59, size.y * 0.557 - (doorC?.size.y ?? 0) / 2);
  //   doorD?.position =
  //       Vector2(size.x * 0.77, size.y * 0.557 - (doorC?.size.y ?? 0) / 2);
  //   sam?.position = Vector2(size.x * 0.26 - (sam?.size.x ?? 0 - 20),
  //       size.y * 0.557 - (sam?.size.y ?? 0) / 3);

  //   _optionsSizing(size);
  //   super.onGameResize(size);
  // }

  // void _optionsSizing(Vector2 size) {
  //   chatWithSamComponent?.position =
  //       Vector2(size.x * 0.13 - (sam?.size.x ?? 0 - 20), size.y * 0.5);

  //   viewSamIdComponent?.position = Vector2(
  //       size.x * 0.13 - (sam?.size.x ?? 0 - 20),
  //       (size.y * 0.5 - (viewSamIdComponent?.height ?? 0)));
  // }

  // void openChat() async {
  //   await Flame.device.setPortrait();
  //   gameRef.overlays.add(ChatScreen.overlayName);
  // }

  // Future _loadButtons() async {
  //   final chatWithSamArtBoard =
  //       await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
  //   final viewSamIdArtBoard =
  //       await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

  //   //     await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
  //   // final bDoorArtBoard =
  //   //     await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

  //   // doorAButton = RiveButtonComponent(aDoorArtBoard, 'Door A', () {
  //   //   gameRef.playerWin();
  //   // });

  //   // doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
  //   //   gameRef.playerLost();
  //   // });

  //   chatWithSamComponent =
  //       RiveButtonComponent(chatWithSamArtBoard, 'Chat with Sam', () {
  //     gameRef.guardIndex = 1;
  //     openChat();
  //     showOptions();
  //   });

  //   viewSamIdComponent =
  //       RiveButtonComponent(viewSamIdArtBoard, 'View Sam’s ID', () {
  //     print("cleck"); //TODO viewID
  //   });

  //   await addAll([
  //     viewSamIdComponent!,
  //     chatWithSamComponent!,
  //   ]);
  // }

  // void showOptions() async {
  //   removeAll([
  //     viewSamIdComponent!,
  //     chatWithSamComponent!,
  //   ]);
  //   // await addAll([doorAButton!, doorBButton!]);
  // }
}
