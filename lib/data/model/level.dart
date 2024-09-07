import 'package:gaurds_game/data/model/math_problem.dart';

import 'guard.dart';

class Level {
  final int id;
  final List<Guard> guards;
  final String riddle;
  final String backgroundAssets;
  final int noOfQuestions;
  final ChallengeType type;
  final int time;
  QuizQuestion question;
  String correctDoor;
  final int noOfDoors;
  List<String> systemInstructions;

  Level({
    required this.id,
    required this.riddle,
    required this.guards,
    required this.type,
    required this.backgroundAssets,
    this.correctDoor = "",
    required this.noOfDoors,
    this.time = 0,
    QuizQuestion? question,
    required this.systemInstructions,
    this.noOfQuestions = 9999,
  }) : question = question ?? QuizQuestion(response: "", options: []);
}

final levels = {
  1: Level(
      id: 1,
      backgroundAssets: "assets/images/background_level_one.svg",
      type: ChallengeType.number,
      guards: [guards['steve']!, guards['willy']!],
      noOfQuestions: 3,
      noOfDoors: 2,
      systemInstructions: [],
      riddle:
          'You have 2 doors and 2 guards: one always tells the truth, and the other always lies. Choose one guard and ask three questions to figure out which door is correct'),
  2: Level(
      id: 2,
      backgroundAssets: "assets/images/background_level_two.svg",
      riddle:
          "Guard Fred knows the correct door to take, but you have just one minute to convince him to reveal it.",
      type: ChallengeType.time,
      guards: [guards['fred']!],
      time: 2,
      noOfDoors: 3,
      systemInstructions: []),
  3: Level(
      id: 3,
      backgroundAssets: "assets/images/background_level_three.svg",
      type: ChallengeType.number,
      riddle:
          "Margaret, the Riddle Master, guards the way. Solve her riddle to proceed. You've 7 attempts only",
      guards: [guards['margaret']!],
      noOfDoors: 4,
      systemInstructions: [],
      noOfQuestions: 7),
  4: Level(
    id: 4,
    backgroundAssets: "assets/images/background_level_four.svg",
    type: ChallengeType.number,
    noOfQuestions: 9,
    noOfDoors: 3,
    riddle:
        "These guards seem bored. You need to make one of them laugh to get the correct door.",
    guards: [
      guards['fred']!,
      guards['margaret']!,
      guards['kane']!,
    ],
    systemInstructions: [],
  ),
  5: Level(
      backgroundAssets: "assets/images/background_level_five.svg",
      id: 5,
      noOfDoors: 2,
      riddle: "Well, What happened here ?",
      guards: [guards['sam']!],
      type: ChallengeType.number,
      noOfQuestions: 12,
      systemInstructions: []),
  6: Level(
      id: 6,
      backgroundAssets: "assets/images/background_level_six.svg",
      riddle: "",
      noOfDoors: 0,
      guards: [],
      type: ChallengeType.time,
      systemInstructions: []),
  7: Level(
      id: 7,
      noOfDoors: 3,
      noOfQuestions: 9,
      backgroundAssets: "assets/images/background_level_seven.svg",
      riddle:
          "One of these guards is carrying a fake ID. Identify him and have him reveal the correct door.",
      guards: [guards['fred']!, guards['sam']!, guards['willy']!],
      type: ChallengeType.number,
      systemInstructions: []),
  8: Level(
      id: 8,
      noOfDoors: 1,
      noOfQuestions: 10,
      backgroundAssets: "assets/images/background_level_eight.svg",
      riddle: "One of thes",
      guards: [guards['fred']!],
      type: ChallengeType.number,
      systemInstructions: []),
  10: Level(
      id: 7,
      backgroundAssets: "assets/images/background_level_finale.svg",
      type: ChallengeType.number,
      guards: [
        guards['newgate']!,
        guards['roger']!,
      ],
      noOfQuestions: 1,
      noOfDoors: 2,
      systemInstructions: [],
      riddle:
          'Two doors with two guards - one lies, one tells the truth You have to choose and open one of these doors, but you can only ask a single question to one of the guards.'),
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


