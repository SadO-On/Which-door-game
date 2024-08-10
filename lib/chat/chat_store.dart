import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/model/chat_model.dart';
import 'package:gaurds_game/data/main_repository.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/locator.dart';
import 'package:mobx/mobx.dart';

import '../data/model/prompt_response.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final int levelNumber;
  final int guardIndex;
  late MainRepository _repository;
  final ScrollController _controller;
  final _player = AudioPlayer();

  _ChatStore(this.levelNumber, this.guardIndex, this.remainingQuestions,
      this._controller) {
    _repository =
        getIt.get<MainRepository>(param1: levelNumber, param2: guardIndex);

    conversations.add(ChatModel(
        text: levels[levelNumber]!.type == ChallengeType.number
            ? "You only have ${levels[levelNumber]!.noOfQuestions} questions to ask, so ask wisely."
            : "You only have ${levels[levelNumber]!.time} minutes to figure out the door, so ask quickly",
        type: ChattingType.receiver));
  }
  @observable
  bool isLoading = false;

  @observable
  bool isTimesUp = false;

  @observable
  int remainingQuestions;

  @observable
  ObservableList<ChatModel> conversations = ObservableList<ChatModel>.of([]);

  @action
  void addNewConversation(ChatModel model) => conversations.add(model);

  @action
  Future sendPrompt(String text) async {
    isLoading = true;
    addNewConversation(ChatModel(text: text, type: ChattingType.sender));
    PromptResponse gemini = await _repository.sendPrompt(text);
    isLoading = false;
    remainingQuestions -= 1;
    await _player.play(AssetSource('audio/chat pop.mp3'));

    addNewConversation(ChatModel(
        text: gemini.response,
        type: ChattingType.receiver,
        mood: gemini.guardMood));
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }
}
