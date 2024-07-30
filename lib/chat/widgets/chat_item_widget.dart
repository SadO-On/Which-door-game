import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/model/chat_model.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    if (chatModel.type == ChattingType.receiver) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              width: 200.0,
              decoration: BoxDecoration(
                  color: const Color(0xffFFF3DF),
                  borderRadius: BorderRadius.circular(8.0)),
              margin: const EdgeInsets.only(right: 10.0),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText(
                    chatModel.text,
                    speed: const Duration(milliseconds: 80),
                    textStyle:
                        const TextStyle(color: Color(0xff382823), fontSize: 17),
                  )
                ],
              ),
            )
          ]);
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                width: 200.0,
                decoration: BoxDecoration(
                    color: const Color(0xffFFF8ED),
                    borderRadius: BorderRadius.circular(8.0)),
                margin: const EdgeInsets.only(left: 10.0),
                child: Text(
                  chatModel.text,
                  style:
                      const TextStyle(color: Color(0xff382823), fontSize: 17),
                ))
          ],
        ),
      );
    }
  }
}
