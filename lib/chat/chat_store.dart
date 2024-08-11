import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';

import '../data/main_repository.dart';
import '../data/model/guard_mood.dart';
import '../data/model/level.dart';
import '../data/model/prompt_response.dart';
import '../locator.dart';
import 'model/chat_model.dart';

part 'chat_store.g.dart';

// ignore: library_private_types_in_public_api
class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final int levelNumber;
  final int guardIndex;
  late MainRepository _repository;
  final ScrollController _controller;
  final player = AudioPlayer();

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
    PromptResponse? gemini;
    try {
      gemini = await _repository.sendPrompt(text);
      remainingQuestions -= 1;
    } catch (e) {
      gemini = PromptResponse(
          guardMood: GuardMood.idle,
          response:
              "Apologies, I wasn't paying attention. Don’t worry, I won’t count that one. Could you repeat it, please?");
    }
    isLoading = false;
    await player.play(AssetSource('audio/chat pop.mp3'));
    addNewConversation(ChatModel(
        text: gemini.response,
        type: ChattingType.receiver,
        mood: gemini.guardMood));
    _controller.jumpTo(_controller.position.maxScrollExtent);
    if (gemini.guardMood == GuardMood.nervous) {
      await player.play(AssetSource('audio/whistle.wav'));
    }
  }
}
