import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gaurds_game/chat/chat_store.dart';
import 'package:gaurds_game/chat/widgets/chat_input_widget.dart';
import 'package:gaurds_game/chat/widgets/chat_list_widget.dart';
import 'package:gaurds_game/chat/widgets/id_card_widget.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/which_door_game_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../widgets/three_dimension_button.dart';
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
    _store = ChatStore(widget.levelNumber, widget.gameScreen.guardIndex,
        levels[widget.levelNumber]!.noOfQuestions);
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
                child: Observer(
                  builder: (_) => TopBarWidget(
                    fontSize: 16,
                    onBackClicked: () {
                      widget.gameScreen.setLandScape();
                      widget.gameScreen.overlays.remove(ChatScreen.overlayName);
                    },
                    title: _store.remainingQuestions > 1
                        ? 'You have ${_store.remainingQuestions} questions left to ask for ${levels[widget.levelNumber]!.guards[widget.gameScreen.guardIndex].name}'
                        : 'You have ${_store.remainingQuestions} question left to ask for ${levels[widget.levelNumber]!.guards[widget.gameScreen.guardIndex].name}',
                  ),
                )),
            IdCardWidget(
              guard: levels[widget.levelNumber]!
                  .guards[widget.gameScreen.guardIndex],
            ),
            ChatListWidget(
              store: _store,
            ),
            Observer(
              builder: (_) {
                if (_store.isLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Text(
                            "${levels[widget.levelNumber]!.guards[widget.gameScreen.guardIndex].name} typing"),
                        const SizedBox(
                          width: 4,
                        ),
                        LoadingAnimationWidget.waveDots(
                            color: const Color(0xffB9B39F), size: 24)
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Observer(builder: (_) {
              if (_store.remainingQuestions <= 0) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'To choose a door press on ',
                      style: TextStyle(
                          color: Color(0xff653E1A),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    ThreeDimensionButton(
                      isRight: false,
                      assetPath: 'assets/images/back_arrow.svg',
                      height: 40,
                      width: 40,
                      iconSize: 28,
                      label: 'example button',
                      shadowColor: const Color(0xffB9B39F),
                      backgroundColor: const Color(0xffE9E4D1),
                      onClick: () {},
                    ),
                    const Text(
                      ' In the left corner',
                      style: TextStyle(
                          color: Color(0xff653E1A),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                );
              } else {
                return ChatInputWidget(
                  onSendClicked: (text) {
                    _store.sendPrompt(text);
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}

// ChatListWidget(),

