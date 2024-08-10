import 'package:gaurds_game/data/model/math_problem.dart';
import 'package:gaurds_game/data/model/system_instructions.dart';

import 'guard.dart';

class Level {
  final int id;
  final List<Guard> guards;
  final String riddle;
  final int noOfQuestions;
  final ChallengeType type;
  final int time;
  QuizQuestion question;
  final List<String> systemInstructions;

  Level({
    required this.id,
    required this.riddle,
    required this.guards,
    required this.type,
    this.time = 0,
    QuizQuestion? question,
    required this.systemInstructions,
    this.noOfQuestions = 9999,
  }) : question = question ?? QuizQuestion(response: "", options: []);
}

final levels = {
  1: Level(
      id: 1,
      type: ChallengeType.number,
      guards: [guards['steve']!, guards['willy']!],
      noOfQuestions: 3,
      systemInstructions: [stevePrompt, willyPrompt],
      riddle:
          'You have 2 doors and 2 guards: one always tells the truth, and the other always lies. Choose one guard and ask three questions to figure out which door is correct'),
  2: Level(
      id: 2,
      riddle:
          "Guard Fred knows the correct door to take, but you have just one minute to convince him to reveal it.",
      type: ChallengeType.time,
      guards: [guards['fred']!],
      time: 2,
      systemInstructions: [fredInstructions]),
  3: Level(
      id: 3,
      type: ChallengeType.number,
      riddle:
          "Margaret, the Riddle Master, guards the way. Solve her riddle to proceed.",
      guards: [guards['margaret']!],
      systemInstructions: [margaretPrompt],
      noOfQuestions: 7),
  4: Level(
    id: 4,
    type: ChallengeType.number,
    noOfQuestions: 9,
    riddle:
        "These guards seem bored. You need to make one of them laugh to get the correct door.",
    guards: [
      guards['fred']!,
      guards['margaret']!,
      guards['kane']!,
    ],
    systemInstructions: [
      fredPromptLevelFour,
      margaretPromptLevelFour,
      kanePromptLevelFour
    ],
  ),
  5: Level(
      id: 5,
      riddle: "Well, What happened here ?",
      guards: [guards['sam']!],
      type: ChallengeType.number,
      noOfQuestions: 12,
      systemInstructions: [sam_level_5_system_instruction]),
  6: Level(
      id: 6,
      riddle: "",
      guards: [],
      type: ChallengeType.time,
      systemInstructions: []),
  7: Level(
      id: 7,
      riddle:
          "One of these guards is carrying a fake ID. Identify him and have him reveal the correct door.",
      guards: [guards['fred']!, guards['sam']!, guards['steve']!],
      type: ChallengeType.number,
      systemInstructions: [""""""]),
};

enum ChallengeType { time, number }



  // 9: Level(
  //     id: 9,
  //     riddle:
  //         "One of these guards is carrying a fake ID. Identify him and have him reveal the correct door.",
  //     guards: [guards['sam']!, guards['steve']!],
  //     type: ChallengeType.number,
  //     noOfQuestions: 9,
  //     systemInstructions: [""""""])