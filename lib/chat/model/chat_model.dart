class ChatModel {
  final String text;
  final ChattingType type;

  ChatModel({required this.text, required this.type});
}

enum ChattingType { sender, receiver }
