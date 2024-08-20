import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mobx/mobx.dart';

import '../data/gemini_ai.dart';
import '../data/model/level.dart';
import '../data/model/system_instructions.dart';
import '../data/storage_repository.dart';
import '../locator.dart';
import '../utils/utils.dart';

part 'level_store.g.dart';

class LevelStore = _LevelStore with _$LevelStore;

abstract class _LevelStore with Store {
  final StorageRepository _repository = getIt<StorageRepository>();
  final GeminiAI _ai = getIt.get<GeminiAI>(param1: Content.system(""));

  @observable
  int level = 7;

  @observable
  bool isLoading = false;

  @action
  void updateLevel(int newLevel) => level = newLevel;

  _LevelStore() {
    // level = _repository.getLevel();
  }

  Future saveNewLevel(int newLevel) async {
    if (level >= newLevel) return;
    await _repository.saveLevel(newLevel);
    updateLevel(newLevel);
  }

  Future getQuizQuestion(VoidCallback onDone) async {
    isLoading = true;
    await _ai.getQuizQuestion().then((value) {
      levels[6]!.question = value;
      isLoading = false;
      Future.delayed(const Duration(milliseconds: 500), () {
        onDone();
      });
    });
  }

  void setRandomDoor(int levelNumber) {
    if (levelNumber == 6) return;
    String correctDoor = getRandomLetter(levels[levelNumber]!.noOfDoors);
    levels[levelNumber]!.correctDoor = correctDoor;
    switch (levelNumber) {
      case 1:
        levels[levelNumber]!.systemInstructions = [
          getSteveInstructions(correctDoor == "A" ? "B" : "A", correctDoor),
          getWillySystemInstruction(correctDoor)
        ];
        break;
      case 2:
        levels[levelNumber]!.systemInstructions = [
          getFredInstructions(correctDoor)
        ];
        break;
      case 3:
        levels[levelNumber]!.systemInstructions = [
          getMargaretSystemInstructions(correctDoor)
        ];
        break;
      case 4:
        levels[levelNumber]!.systemInstructions = [
          getFredLevelFourSystemInstructions(correctDoor),
          getMargaretLevelFourSystemInstructions(correctDoor),
          getKaneLevelFourSystemInstructions(correctDoor)
        ];
        break;
      case 5:
        levels[levelNumber]!.systemInstructions = [
          getSamSystemInstruction(correctDoor)
        ];
        break;

      case 7:
        levels[levelNumber]!.systemInstructions = ["", "", ""];
      case 10:
        levels[levelNumber]!.systemInstructions = [
          getNewgateSystemInstruction(correctDoor),
          getRogerInstructions(correctDoor == "A" ? "B" : "A", correctDoor)
        ];
        break;
      default:
    }
  }

  Future gameFinished() async {
    await _repository.setFinishTheGame();
  }

  bool getGameFinished() {
    return _repository.isFinishTheGame();
  }

  Future resetGame() async {
    updateLevel(1);
    await _repository.resetGame();
  }
}
