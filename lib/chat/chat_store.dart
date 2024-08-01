import 'package:gaurds_game/chat/model/chat_model.dart';
import 'package:gaurds_game/data/main_repository.dart';
import 'package:gaurds_game/locator.dart';
import 'package:mobx/mobx.dart';

import '../data/model/prompt_response.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final int levelNumber;
  final int guardIndex;
  late MainRepository _repository;

  _ChatStore(this.levelNumber, this.guardIndex) {
    _repository = getIt.get<MainRepository>(
        param1:
            levelNumber); //TODO pass gaurdInex to get the correct system instructions
  }
  @observable
  bool isLoading = false;

  @observable
  ObservableList<ChatModel> conversations = ObservableList<ChatModel>.of([
    ChatModel(
        text: "You only have 3 questions to ask, so ask wisely.",
        type: ChattingType.receiver)
  ]);

  @action
  void addNewConversation(ChatModel model) => conversations.add(model);

  @action
  Future sendPrompt(String text) async {
    isLoading = true;
    addNewConversation(ChatModel(text: text, type: ChattingType.sender));
    PromptResponse gemini = await _repository.sendPrompt(text);

    addNewConversation(
        ChatModel(text: gemini.response, type: ChattingType.receiver));
  }
}
