import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/data/model/math_problem.dart';
import 'package:gaurds_game/game/components/loading_screen.dart';
import 'package:gaurds_game/game/components/lost_popup.dart';
import 'package:gaurds_game/game/components/mission_component.dart';
import 'package:gaurds_game/game/components/timer_component.dart';
import 'package:gaurds_game/game/components/win_popup.dart';
import 'package:gaurds_game/game/level06/components/answer_component.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';

import '../components/rive_button_component.dart';

class GameLevelSix extends Component with HasGameRef<WhichDoorGameScreen> {
  GameLevelSix({required this.level});
  Level level;
  RiveButtonComponent? doorAButton;
  RiveButtonComponent? doorBButton;
  RiveButtonComponent? doorCButton;
  RiveButtonComponent? doorDButton;
  @override
  FutureOr<void> onLoad() async {
    await addAll([
      MissionComponent(text: level.question.response),
      LevelTimerComponent(
          120, "2:00", () => gameRef.showOverlay(LostPopup.overlayName))
    ]);
    await _doorsButtons(level.question.options);

    gameRef.hideOverlay(LoadingScreen.overlayName);
    level.question.options.asMap().forEach(
        (index, value) async => await add(AnswerComponent(value.value, index)));

    return super.onLoad();
  }

  FutureOr<void> _doorsButtons(List<Option>? options) async {
    final aDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final bDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final cDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));
    final dDoorArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/button_light.riv'));

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
    final btnSize = Vector2(size.x * 0.19, size.y * 0.1);
    doorAButton?.size = btnSize;
    doorBButton?.size = btnSize;
    doorCButton?.size = btnSize;
    doorDButton?.size = btnSize;
    doorAButton?.position = Vector2(size.x * 0.09, size.y * 0.15);
    doorBButton?.position = Vector2(size.x * 0.32, size.y * 0.15);
    doorCButton?.position = Vector2(size.x * 0.555, size.y * 0.15);
    doorDButton?.position = Vector2(size.x * 0.79, size.y * 0.15);

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
