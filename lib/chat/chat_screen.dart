import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../utils/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../data/model/level.dart';
import '../game/components/loading_screen.dart';
import '../game/which_door_game_screen.dart';
import '../widgets/three_dimension_button.dart';
import '../widgets/top_bar_widget.dart';
import 'chat_store.dart';
import 'widgets/chat_input_widget.dart';
import 'widgets/chat_list_widget.dart';
import 'widgets/id_card_widget.dart';

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
  final _controller = ScrollController();
  @override
  void initState() {
    _store = ChatStore(widget.levelNumber, widget.gameScreen.guardIndex,
        levels[widget.levelNumber]!.noOfQuestions, _controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _store.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDE3D4),
      body: MediaQuery.of(context).orientation == Orientation.landscape
          ? const LoadingScreen()
          : SafeArea(
              child: Stack(alignment: Alignment.center, children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Observer(
                          builder: (_) => TopBarWidget(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            onBackClicked: () {
                              widget.gameScreen.setLandScape();
                              widget.gameScreen.overlays
                                  .remove(ChatScreen.overlayName);
                            },
                            title: levels[widget.levelNumber]!.type ==
                                    ChallengeType.time
                                ? 'You have ${levels[widget.levelNumber]!.time} minutes to convince the guard'
                                : _store.remainingQuestions > 1
                                    ? 'You have ${_store.remainingQuestions} questions left to ask for ${levels[widget.levelNumber]!.guards[widget.gameScreen.guardIndex].name}'
                                    : 'You have ${_store.remainingQuestions} question left to ask for ${levels[widget.levelNumber]!.guards[widget.gameScreen.guardIndex].name}',
                          ),
                        )),
                    Observer(
                      builder: (context) => IdCardWidget(
                        guard: levels[widget.levelNumber]!
                            .guards[widget.gameScreen.guardIndex],
                        mood: _store.conversations.last.mood,
                      ),
                    ),
                    if (levels[widget.levelNumber]!.type == ChallengeType.time)
                      Countdown(
                        seconds: levels[widget.levelNumber]!.time * 60,
                        build: (BuildContext context, double time) => Text(
                          "Timer: ${time.toMMSS()}",
                          style: const TextStyle(
                              color: Color(0xff653E1A),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        interval: const Duration(milliseconds: 100),
                        onFinished: () {
                          _store.isTimesUp = true;
                        },
                      ),
                    ChatListWidget(
                      store: _store,
                      listScrollController: _controller,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.18,
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Observer(builder: (_) {
                    if ((levels[widget.levelNumber]!.type ==
                                ChallengeType.number &&
                            _store.remainingQuestions <= 0) ||
                        _store.isTimesUp) {
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
                  }),
                )
              ]),
            ),
    );
  }
}

// ChatListWidget(),

