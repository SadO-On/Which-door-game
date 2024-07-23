import 'guard.dart';

class Level {
  final List<Guard> guards;
  final String riddle;
  final int noOfQuestions;

  Level(
      {required this.riddle,
      required this.guards,
      required this.noOfQuestions});
}

final levels = {
  1: Level(
      guards: [guards['steve']!],
      noOfQuestions: 3,
      riddle:
          'You have 2 doors and 2 guards: one always tells the truth, and the other always lies. Choose one guard and ask three questions to figure out which door is correct')
};
