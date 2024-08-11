import 'package:gaurds_game/data/model/guard_mood.dart';

class ChatModel {
  final String text;
  final ChattingType type;
  final GuardMood mood;
  ChatModel(
      {required this.text, required this.type, this.mood = GuardMood.idle});
}

enum ChattingType { sender, receiver }
