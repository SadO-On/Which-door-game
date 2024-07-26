import 'package:gaurds_game/data/main_repository.dart';
import 'package:gaurds_game/locator.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final int levelNumber;
  _ChatStore({required this.levelNumber});

  late MainRepository _repository;

  void initRepo() {
    _repository = getIt.get<MainRepository>(param1: levelNumber);
    _repository.initModel();
  }

  @observable
  bool isLoading = false;
}
