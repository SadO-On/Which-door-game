import 'dart:math';

import 'package:package_info_plus/package_info_plus.dart';

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
  if (count == 1) return "A";
  if (count < 2 || count > 4) {
    throw ArgumentError('Count must be between 2 and 4');
  }
  const letters = 'ABCD';
  String selectedLetters = letters.substring(0, count);
  int randomIndex = Random().nextInt(count);
  return selectedLetters[randomIndex];
}

Future<String> getVersionInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  return '$version ($buildNumber) - BETA';
}
