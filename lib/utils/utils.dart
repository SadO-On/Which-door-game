import 'dart:math';

extension TimeFormatting on double {
  String toMMSS() {
    int totalSeconds = toInt();
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}

String getRandomLetter(int count) {
  if (count < 2 || count > 4) {
    throw ArgumentError('Count must be between 2 and 4');
  }
  const letters = 'ABCD';
  String selectedLetters = letters.substring(0, count);
  int randomIndex = Random().nextInt(count);
  return selectedLetters[randomIndex];
}
