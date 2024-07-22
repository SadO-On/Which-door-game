import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_input_widget.dart';
import 'package:gaurds_game/chat/chat_list_widget.dart';
import 'package:gaurds_game/chat/id_card_widget.dart';

import '../widgets/top_bar_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDE3D4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TopBarWidget(
                  onBackClicked: () {},
                  title: 'You have 3 questions to ask for Steve',
                )),
            const IdCardWidget(),
            ChatListWidget(),
            ChatInputWidget(
              onSendClicked: (text) {},
            )
          ],
        ),
      ),
    );
  }
}

// ChatListWidget(),

