import 'package:flutter/material.dart';
import 'package:gaurds_game/widgets/three_dimension_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class ChatInputWidget extends StatelessWidget {
  ChatInputWidget({super.key, required this.onSendClicked});

  final Function(String text) onSendClicked;
  String prompt = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              color: Colors.white,
              width: Adaptive.w(70),
              child: TextField(
                onChanged: (value) {
                  prompt = value;
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  hintStyle: TextStyle(
                      color: Color(0xffB9B39F), fontWeight: FontWeight.bold),
                  hintText: 'Ask the Guard',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              )),
          ThreeDimensionButton(
              size: 66,
              assetPath: 'assets/images/message_send.svg',
              label: 'Send Button',
              iconSize: 32,
              isRight: true,
              onClick: () {
                onSendClicked(prompt);
              })
        ],
      ),
    );
  }
}
