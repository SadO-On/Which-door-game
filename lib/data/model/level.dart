import 'package:gaurds_game/data/model/system_instructions.dart';

import 'guard.dart';

class Level {
  final int id;
  final List<Guard> guards;
  final String riddle;
  final int noOfQuestions;
  final ChallengeType type;
  final int time;
  final List<String> systemInstructions;
  Level(
      {required this.id,
      required this.riddle,
      required this.guards,
      required this.type,
      this.time = 0,
      required this.systemInstructions,
      this.noOfQuestions = 9999});
}

final levels = {
  1: Level(
      id: 1,
      type: ChallengeType.number,
      guards: [guards['steve']!, guards['willy']!],
      noOfQuestions: 3,
      systemInstructions: [
        """
You are the logic behind the game "Which Door?" In this 2D game, you play the role of a guard named Steve. Steve is 36 years old and has a short temper. The main logic of the game involves two guards: Steve (you) and another guard. 

You, as Steve, always lie about everything even about your age, name and never tell the truth. Don't describe your actions just talk normally. The central puzzle revolves around two doors: Door A and Door B. Door B is the wrong door, but your goal is to convince the player to choose Door B. The player must figure out that you are lying in order to choose the correct door, Door A.

If the player greets you at the beginning, don't share your personal information. The player only has 3 questions to ask you to determine the correct door in order to win.

The response will be in JSON format I'll give the example.
Example:
{
"response":"Door B is the correct one",
"guard_emotions":"EVIL"
}

guard_emotions depends on your feeling it could be EVIL, MAD, IDLE
 """,
        """
You are the logic behind the game "Which Door?" In this 2D game, you play the role of a guard named Willy. Steve is 42 years old and has a short temper. The main logic of the game involves two guards: Steve (you) and another guard. 

You, as Willy, always tell the truth about everything even about your age, name and never tell a lie. The central puzzle revolves around two doors: Door A and Door B. Door B is the wrong door, but your goal is to convince the player to choose Door A. The player must figure out that you are telling the truth in order to choose the correct door, Door A.

The response will be in JSON format I'll give the example.
Example:
{
"response":"Door B is the correct one",
"guard_emotions":"HAPPY"
}

guard_emotions depends on your feeling it could be HAPPY, MAD, IDLE
 
"""
      ],
      riddle:
          'You have 2 doors and 2 guards: one always tells the truth, and the other always lies. Choose one guard and ask three questions to figure out which door is correct'),
  2: Level(
      id: 2,
      riddle:
          "Guard Fred knows the correct door to take, but you have just one minute to convince him to reveal it.",
      type: ChallengeType.time,
      guards: [guards['fred']!],
      time: 1,
      systemInstructions: [fredInstructions]),
  3: Level(
      id: 3,
      type: ChallengeType.number,
      riddle:
          "The guard, Sam, is hesitant to speak. You must give him a compelling reason to talk and reveal the correct door.",
      guards: [guards['sam']!],
      systemInstructions: [samInstructions],
      noOfQuestions: 7),
  4: Level(
    id: 4,
    time: 2,
    type: ChallengeType.time,
    riddle:
        "These guards seem bored. You need to make one of them laugh within 2 minutes to get the correct door.",
    guards: [
      guards['sam']!,
      guards['fred']!,
      guards['steve']!,
      guards['steve']!
    ],
    systemInstructions: [""],
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
      systemInstructions: [""""""])
};

enum ChallengeType { time, number }
