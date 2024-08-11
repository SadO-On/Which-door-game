import 'package:flame/components.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../../data/model/level.dart';

class GameLevelNine extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelNine({required this.level});
  final Level level;
  // SvgComponent? door;
  // GuardComponent? kane, steve;
  // RiveButtonComponent? viewKaneIdComponent,
  //     viewSteveIdComponent,
  //     chatWithSteveComponent,
  //     chatWithKaneComponent;
  // SvgComponent? background;

  // @override
  // FutureOr<void> onLoad() async {
  //   final svgInstance = await Svg.load('images/background_level_nine.svg');

  //   background = SvgComponent(
  //     size: gameRef.size,
  //     svg: svgInstance,
  //   );

  //   addAll([background!, MissionComponent(text: level.riddle)]);
  //   final sprite = await Svg.load('images/door_a.svg');
  //   final size = Vector2(130, 265);
  //   door = SvgComponent(size: size, svg: sprite);
  //   add(door!);

  //   final steveArtBoard = await loadArtboard(
  //       RiveFile.asset('assets/rive/steve_idle_standing.riv'));
  //   steve = GuardComponent(artboard: steveArtBoard);

  //   final kaneArtBoard = await loadArtboard(
  //       RiveFile.asset('assets/rive/kane_idle_standing.riv'));
  //   kane = GuardComponent(artboard: kaneArtBoard);
  //   addAll([kane!, steve!]);

  //   await _loadButtons();
  //   return super.onLoad();
  // }

  // @override
  // void onGameResize(Vector2 size) {
  //   door?.position = Vector2(size.x * 0.5 - (door?.size.x ?? 0) / 2,
  //       size.y * 0.557 - (door?.size.y ?? 0) / 2);

  //   kane?.position = Vector2(size.x * 0.45 - (kane?.size.x ?? 0 - 20),
  //       size.y * 0.557 - (kane?.size.y ?? 0) / 3);

  //   steve?.position = Vector2(size.x * 0.65 - (steve?.size.x ?? 0 - 20),
  //       size.y * 0.557 - (steve?.size.y ?? 0) / 3);

  //   _optionsSizing(size);

  //   background?.size = size;
  //   super.onGameResize(size);
  // }

  // void _optionsSizing(Vector2 size) {
  //   chatWithKaneComponent?.position = Vector2(size.x * 0.20, size.y * 0.5);

  //   chatWithSteveComponent?.position = Vector2(size.x * 0.64, size.y * 0.5);

  //   viewSteveIdComponent?.position = Vector2(
  //       size.x * 0.64, (size.y * 0.5 - (viewKaneIdComponent?.height ?? 0)));

  //   viewKaneIdComponent?.position = Vector2(
  //       size.x * 0.20, (size.y * 0.5 - (viewSteveIdComponent?.height ?? 0)));
  // }

  // void openChat() async {
  //   await Flame.device.setPortrait();
  //   gameRef.showOverlay(ChatScreen.overlayName);
  // }

  // Future _loadButtons() async {
  //   final chatWithWillyArtBoard =
  //       await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
  //   final chatWithSteveArtBoard =
  //       await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
  //   final viewWillyIdArtBoard =
  //       await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
  //   final viewSteveIdArtBoard =
  //       await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

  //   chatWithKaneComponent =
  //       RiveButtonComponent(chatWithWillyArtBoard, 'Chat with Kane', () {
  //     gameRef.guardIndex = 1;
  //     openChat();
  //   });

  //   chatWithSteveComponent =
  //       RiveButtonComponent(chatWithSteveArtBoard, 'Chat with Steve', () {
  //     gameRef.guardIndex = 0;
  //     openChat();
  //   });

  //   viewSteveIdComponent =
  //       RiveButtonComponent(viewSteveIdArtBoard, 'View Steve’s ID', () {
  //     gameRef.guardIndex = 0;

  //     game.showOverlay(GuardIdPopup.overlayName);
  //   });

  //   viewKaneIdComponent =
  //       RiveButtonComponent(viewWillyIdArtBoard, 'View Willy’s ID', () {
  //     gameRef.guardIndex = 1;

  //     game.showOverlay(GuardIdPopup.overlayName);
  //   });

  //   await addAll([
  //     viewSteveIdComponent!,
  //     viewKaneIdComponent!,
  //     chatWithSteveComponent!,
  //     chatWithKaneComponent!
  //   ]);
  // }
}
