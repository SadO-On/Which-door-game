import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:gaurds_game/data/gemini_ai.dart';
import 'package:gaurds_game/data/model/math_problem.dart';
import 'package:gaurds_game/game/components/loading_screen.dart';
import 'package:gaurds_game/game/components/lost_popup.dart';
import 'package:gaurds_game/game/components/mission_component.dart';
import 'package:gaurds_game/game/components/win_popup.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';
import 'package:gaurds_game/locator.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../components/rive_button_component.dart';
import '../level01/components/lamp_component.dart';

class GameLevelSix extends Component with HasGameRef<WhichDoorGameScreen> {
  final GeminiAI _ai = getIt.get<GeminiAI>(param1: Content.system(""));

  QuizQuestion? _mathProblem;
  SvgComponent? doorA;
  SvgComponent? doorB;
  SvgComponent? doorC;
  SvgComponent? doorD;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  RiveButtonComponent? doorCButton;
  RiveButtonComponent? doorDButton;
  LampComponent? lampAnimation;

  @override
  FutureOr<void> onLoad() async {
    final svgInstance = await Svg.load('images/background_level_06.svg');
    final backgroundSize = gameRef.size;
    final background = SvgComponent(
      size: backgroundSize,
      svg: svgInstance,
    );

    _mathProblem = await _ai.getQuizQuestion();
    addAll([background, MissionComponent(_mathProblem?.response ?? "")]);
    await _doorsAndMessages();
    await _doorsButtons(_mathProblem?.options);
    final lampArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/lamp_animation.riv'));
    lampAnimation = LampComponent(artboard: lampArtBoard);
    add(lampAnimation!);
    gameRef.hideOverlay(LoadingScreen.overlayName);

    return super.onLoad();
  }

  FutureOr<void> _doorsAndMessages() async {
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
  }

  FutureOr<void> _doorsButtons(List<Option>? options) async {
    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final cDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));
    final dDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button.riv'));

    doorAButton = RiveButtonComponent(aDoorArtBoard, 'Door A', () {
      doWeHaveWinner(0, options);
    });

    doorBButton = RiveButtonComponent(bDoorArtBoard, 'Door B', () {
      doWeHaveWinner(1, options);
    });

    doorCButton = RiveButtonComponent(cDoorArtBoard, 'Door C', () {
      doWeHaveWinner(2, options);
    });

    doorDButton = RiveButtonComponent(dDoorArtBoard, 'Door D', () {
      doWeHaveWinner(3, options);
    });
    await addAll([doorAButton!, doorBButton!, doorCButton!, doorDButton!]);
  }

  @override
  void onGameResize(Vector2 size) {
    doorA?.position = Vector2(size.x * 0.20, size.y * 0.41);
    doorB?.position = Vector2(size.x * 0.40, size.y * 0.41);
    doorC?.position = Vector2(size.x * 0.60, size.y * 0.41);
    doorD?.position = Vector2(size.x * 0.80, size.y * 0.41);

    doorAButton?.position = Vector2(size.x * 0.165, size.y * 0.30);
    doorBButton?.position = Vector2(size.x * 0.37, size.y * 0.30);
    doorCButton?.position = Vector2(size.x * 0.57, size.y * 0.30);
    doorDButton?.position = Vector2(size.x * 0.77, size.y * 0.30);
    lampAnimation?.scale = Vector2.all(0.8);
    lampAnimation?.position = Vector2(size.x * 0.05, size.y * 0.49);
    super.onGameResize(size);
  }

  void doWeHaveWinner(int index, List<Option>? options) {
    if (isCorrectAnswer(index, options)) {
      gameRef.showOverlay(WinPopup.overlayName);
    } else {
      gameRef.showOverlay(LostPopup.overlayName);
    }
  }

  bool isCorrectAnswer(int index, List<Option>? options) {
    return options?[index].isCorrect ?? false;
  }
}
