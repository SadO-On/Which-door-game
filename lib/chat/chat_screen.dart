import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaurds_game/chat/chat_store.dart';
import 'package:gaurds_game/chat/widgets/chat_input_widget.dart';
import 'package:gaurds_game/chat/widgets/chat_list_widget.dart';
import 'package:gaurds_game/chat/widgets/id_card_widget.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';
import '../widgets/top_bar_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.levelNumber, required this.gameScreen});
  final int levelNumber;
  final WhichDoorGameScreen gameScreen;

  static const String overlayName = "ChatScreen";
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatStore _store;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    _store = ChatStore(widget.levelNumber, widget.gameScreen.guardIndex);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
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
                  onBackClicked: () {
                    widget.gameScreen.overlays.remove(ChatScreen.overlayName);
                  },
                  title:
                      'You have ${levels[widget.levelNumber]!.noOfQuestions} questions to ask for ${levels[widget.levelNumber]!.guards[widget.gameScreen.guardIndex].name}',
                )),
            IdCardWidget(
              guard: levels[widget.levelNumber]!
                  .guards[widget.gameScreen.guardIndex],
            ),
            ChatListWidget(
              store: _store,
            ),
            ChatInputWidget(
              onSendClicked: (text) {
                _store.sendPrompt(text);
              },
            )
          ],
        ),
      ),
    );
  }
}

// ChatListWidget(),

