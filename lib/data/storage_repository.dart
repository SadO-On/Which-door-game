import '../locator.dart';
import 'sp.dart';

class StorageRepository {
  final SP _sp = getIt.get<SP>();

  int getLevel() {
    return _sp.getLevelNumber();
  }

  Future saveLevel(int level) async {
    await _sp.saveLevel(level);
  }
}
