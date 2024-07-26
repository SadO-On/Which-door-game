import 'package:gaurds_game/data/main_repository.dart';
import 'package:gaurds_game/locator.dart';
import 'package:mobx/mobx.dart';

import '../data/model/prompt_response.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final int levelNumber;
  late MainRepository _repository;

  _ChatStore(this.levelNumber) {
    _repository = getIt.get<MainRepository>(param1: levelNumber);
  }
  @observable
  bool isLoading = false;

  @observable
  ObservableList<String> conversations = ObservableList<String>.of(
      ["You only have 3 questions to ask, so choose wisely."]);

  @action
  void addNewConversation(String text) => conversations.add(text);

  @action
  Future sendPrompt(String text) async {
    isLoading = true;
    addNewConversation(text);
    PromptResponse gemini = await _repository.sendPrompt(text);

    addNewConversation(gemini.response);
  }
}
