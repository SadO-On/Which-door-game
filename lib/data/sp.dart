import 'package:shared_preferences/shared_preferences.dart';

class SP {
  SP({required this.pref});
  final SharedPreferences pref;

  int getLevelNumber() {
    return pref.getInt('level') ?? 1;
  }

  bool isFirstTime() {
    return pref.getBool('cutscene_first') ?? true;
  }

  Future setFirstTime() async {
    await pref.setBool('cutscene_first', false);
  }

  Future saveLevel(int levelNumber) async {
    await pref.setInt('level', levelNumber);
  }

  Future resetGame() async {
    await pref.clear();
  }

  bool isFinishTheGame() {
    return pref.getBool('game_finish') ?? false;
  }

  Future setFinishTheGame() async {
    await pref.setBool('game_finish', true);
  }
}
