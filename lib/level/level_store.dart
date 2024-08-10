import 'package:gaurds_game/data/storage_repository.dart';
import 'package:gaurds_game/locator.dart';
import 'package:mobx/mobx.dart';

part 'level_store.g.dart';

class LevelStore = _LevelStore with _$LevelStore;

abstract class _LevelStore with Store {
  final StorageRepository _repository = getIt<StorageRepository>();

  @observable
  int level = 1;

  @action
  void updateLevel(int newLevel) => level = newLevel;

  _LevelStore() {
    level = _repository.getLevel();
  }

  Future saveNewLevel(int newLevel) async {
    if (level >= newLevel) return;
    await _repository.saveLevel(newLevel);
    updateLevel(newLevel);
  }
}
