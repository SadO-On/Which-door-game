import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/level/level_button_widget.dart';
import 'package:gaurds_game/level/level_store.dart';
import 'package:gaurds_game/utils/theme.dart';

import '../locator.dart';
import '../utils/routes.dart';
import '../widgets/top_bar_widget.dart';

class LevelScreen extends StatelessWidget {
  LevelScreen({super.key});
  final _store = getIt.get<LevelStore>();
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
                  return Observer(
                    builder: (context) => LevelButtonWidget(
                        onClick: (levelNumber) async {
                          if (levelNumber == 1) {
                            Navigator.pushNamed(context, AppRoutes.cutScene,
                                arguments: "assets/videos/cutscene.mp4");
                            return;
                          }
                          Navigator.pushNamed(context, AppRoutes.game,
                              arguments: levels[index + 1]!);
                        },
                        isOpened: index < _store.level,
                        levelNumber: index + 1),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
