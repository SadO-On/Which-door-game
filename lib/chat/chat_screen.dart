import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_input_widget.dart';
import 'package:gaurds_game/chat/chat_list_widget.dart';
import 'package:gaurds_game/chat/id_card_widget.dart';
import 'package:gaurds_game/data/model/guard.dart';
import 'package:gaurds_game/data/model/level.dart';

import '../widgets/top_bar_widget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final Guard guard = levels[1]!.guards.first;
  final int noQuestions = levels[1]!.noOfQuestions;

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
                  title:
                      'You have $noQuestions questions to ask for ${guard.name}',
                )),
            IdCardWidget(
              guard: guard,
            ),
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

