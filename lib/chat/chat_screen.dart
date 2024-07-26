import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_store.dart';
import 'package:gaurds_game/chat/widgets/chat_input_widget.dart';
import 'package:gaurds_game/chat/widgets/chat_list_widget.dart';
import 'package:gaurds_game/chat/widgets/id_card_widget.dart';
import 'package:gaurds_game/data/model/level.dart';

import '../widgets/top_bar_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.levelNumber, required this.guardIndex});
  final int levelNumber;
  final int guardIndex;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatStore _store;

  @override
  void initState() {
    _store = ChatStore(levelNumber: widget.levelNumber);
    _store.initRepo();
    super.initState();
  }

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
                  fontSize: 16,
                  onBackClicked: () {},
                  title:
                      'You have ${levels[widget.levelNumber]!.noOfQuestions} questions to ask for ${levels[widget.levelNumber]!.guards[widget.guardIndex].name}',
                )),
            IdCardWidget(
              guard: levels[widget.levelNumber]!.guards[widget.guardIndex],
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

