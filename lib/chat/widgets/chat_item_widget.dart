import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatItemWidget extends StatelessWidget {
  var index;
  final String text;
  ChatItemWidget({this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    if (index % 2 != 0) {
      //This is the sent message. We'll later use data from firebase instead of index to determine the message is sent or received.
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
              child: Text(
                text,
                style: TextStyle(color: Color(0xff382823), fontSize: 17),
              ),
            )
          ]);
    } else {
      // This is a received message
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
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      text,
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                          color: Color(0xff382823), fontSize: 17),
                    )
                  ],
                ))
          ],
        ),
      );
    }
  }
}
