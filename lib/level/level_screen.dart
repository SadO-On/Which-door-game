import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_screen.dart';
import 'package:gaurds_game/level/level_button_widget.dart';
import 'package:gaurds_game/utils/theme.dart';

import '../widgets/top_bar_widget.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TopBarWidget(
                  fontSize: 24,
                  onBackClicked: () {
                    Navigator.pop(context);
                  },
                  title: 'Levels',
                )),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 24,
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return LevelButtonWidget(
                      onClick: (levelNumber) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                levelNumber: levelNumber, guardIndex: 0)));
                      },
                      isOpened: index < 1,
                      levelNumber: index + 1);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
