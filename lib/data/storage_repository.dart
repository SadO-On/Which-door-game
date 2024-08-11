import '../locator.dart';
import 'sp.dart';

class StorageRepository {
  final SP _sp = getIt.get<SP>();

  int getLevel() {
    return _sp.getLevelNumber();
  }

  Future setFirstTime() async {
    await _sp.setFirstTime();
  }

  Future saveLevel(int level) async {
    await _sp.saveLevel(level);
  }

  bool isFirstTime() {
    return _sp.isFirstTime();
  }
}
