// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ChatStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isTimesUpAtom =
      Atom(name: '_ChatStore.isTimesUp', context: context);

  @override
  bool get isTimesUp {
    _$isTimesUpAtom.reportRead();
    return super.isTimesUp;
  }

  @override
  set isTimesUp(bool value) {
    _$isTimesUpAtom.reportWrite(value, super.isTimesUp, () {
      super.isTimesUp = value;
    });
  }

  late final _$remainingQuestionsAtom =
      Atom(name: '_ChatStore.remainingQuestions', context: context);

  @override
  int get remainingQuestions {
    _$remainingQuestionsAtom.reportRead();
    return super.remainingQuestions;
  }

  @override
  set remainingQuestions(int value) {
    _$remainingQuestionsAtom.reportWrite(value, super.remainingQuestions, () {
      super.remainingQuestions = value;
    });
  }

  late final _$conversationsAtom =
      Atom(name: '_ChatStore.conversations', context: context);

  @override
  ObservableList<ChatModel> get conversations {
    _$conversationsAtom.reportRead();
    return super.conversations;
  }

  @override
  set conversations(ObservableList<ChatModel> value) {
    _$conversationsAtom.reportWrite(value, super.conversations, () {
      super.conversations = value;
    });
  }

  late final _$sendPromptAsyncAction =
      AsyncAction('_ChatStore.sendPrompt', context: context);

  @override
  Future<dynamic> sendPrompt(String text) {
    return _$sendPromptAsyncAction.run(() => super.sendPrompt(text));
  }

  late final _$_ChatStoreActionController =
      ActionController(name: '_ChatStore', context: context);

  @override
  void addNewConversation(ChatModel model) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.addNewConversation');
    try {
      return super.addNewConversation(model);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isTimesUp: ${isTimesUp},
remainingQuestions: ${remainingQuestions},
conversations: ${conversations}
    ''';
  }
}
