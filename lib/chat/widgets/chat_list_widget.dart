import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gaurds_game/chat/chat_store.dart';

import 'chat_item_widget.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget(
      {super.key, required this.store, required this.listScrollController});
  final ScrollController listScrollController;
  final ChatStore store;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Observer(
        builder: (context) => ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: store.conversations.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemBuilder: (context, index) =>
              ChatItemWidget(chatModel: store.conversations[index]),
          reverse: false,
          controller: listScrollController,
        ),
      ),
    );
  }
}
