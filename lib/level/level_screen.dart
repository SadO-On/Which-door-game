import 'package:flutter/material.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/game_play_container.dart';
import 'package:gaurds_game/level/level_button_widget.dart';
import 'package:gaurds_game/utils/theme.dart';
import 'package:gaurds_game/video/cutscene_container.dart';

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
                        if (levelNumber == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const CutSceneContainerScreen(
                                      videoAsset:
                                          "assets/videos/cutscene.mp4")));
                          return;
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GamePlayContainer(
                                  level: levels[index + 1]!,
                                )));
                      },
                      isOpened: index < 9,
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
