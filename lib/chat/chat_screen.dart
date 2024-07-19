import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'chat_list_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ChatListWidget(),
            Row(
              children: [
                SizedBox(
                    height: 80,
                    width: Adaptive.w(70),
                    child: const TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(),
                        hintText: '1',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    )),
                Text('btn go here')
              ],
            )
          ],
        ),
      ),
    );
  }
}
