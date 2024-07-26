import 'package:flutter/material.dart';

import 'chat_item_widget.dart';

class ChatListWidget extends StatelessWidget {
  ChatListWidget({super.key});
  final ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: 1,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) => ChatItemWidget(index),
        reverse: true,
        controller: listScrollController,
      ),
    );
  }
}
