import 'package:shared_preferences/shared_preferences.dart';

class SP {
  SP({required this.pref});
  final SharedPreferences pref;

  int getLevelNumber() {
    return pref.getInt('level') ?? 1;
  }

  Future saveLevel(int levelNumber) async {
    await pref.setInt('level', levelNumber);
  }
}
