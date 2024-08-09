import 'package:gaurds_game/data/model/guardMood.dart';

class ChatModel {
  final String text;
  final ChattingType type;
  final GuardMood mood;
  ChatModel(
      {required this.text, required this.type, this.mood = GuardMood.IDLE});
}

enum ChattingType { sender, receiver }
