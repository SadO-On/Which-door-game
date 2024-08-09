import 'package:flutter/material.dart';
import 'package:gaurds_game/widgets/three_dimension_button.dart';

// ignore: must_be_immutable
class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({super.key, required this.onSendClicked});

  final Function(String text) onSendClicked;

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  String prompt = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                onChanged: (value) {
                  prompt = value;
                },
                textAlign: TextAlign.center,
                controller: _controller,
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
              width: 66,
              height: 66,
              shadowColor: const Color(0xffB9B39F),
              backgroundColor: const Color(0xffE9E4D1),
              assetPath: 'assets/images/message_send.svg',
              label: 'Send Button',
              iconSize: 32,
              isRight: true,
              onClick: () {
                widget.onSendClicked(prompt);
                prompt = '';
                _controller.clear();
              })
        ],
      ),
    );
  }
}
