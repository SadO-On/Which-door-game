import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/components/loading_screen.dart';
import 'package:gaurds_game/level/final_level.dart';
import 'package:gaurds_game/level/level_button_widget.dart';
import 'package:gaurds_game/level/level_store.dart';
import 'package:gaurds_game/utils/theme.dart';

import '../locator.dart';
import '../utils/routes.dart';
import '../widgets/three_dimension_button.dart';
import '../widgets/top_bar_widget.dart';

class LevelScreen extends StatelessWidget {
  LevelScreen({super.key});
  final _store = getIt.get<LevelStore>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? const LoadingScreen()
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Observer(builder: (_) {
                if (_store.isLoading) {
                  return const LoadingScreen();
                }
                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
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
                    _store.level == 7 && !_store.getGameFinished()
                        ? FInalLevelWidget(
                            onClicked: () {
                              _store.setRandomDoor(7);
                              Navigator.pushNamed(context, AppRoutes.game,
                                  arguments: levels[7]!);
                            },
                          )
                        : Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 24,
                                crossAxisCount: 3,
                              ),
                              itemCount: _store.getGameFinished() ? 7 : 6,
                              itemBuilder: (context, index) {
                                return Observer(
                                  builder: (_) => LevelButtonWidget(
                                      onClick: (levelNumber) async {
                                        _store.setRandomDoor(levelNumber);
                                        if (levelNumber == 1) {
                                          Navigator.pushNamed(
                                              context, AppRoutes.cutScene,
                                              arguments:
                                                  "assets/videos/cutscene.mp4");
                                          return;
                                        }
                                        if (levelNumber == 6) {
                                          await _store.getQuizQuestion(() {
                                            Navigator.pushNamed(
                                                _scaffoldKey.currentContext!,
                                                AppRoutes.game,
                                                arguments: levels[6]);
                                          });
                                          return;
                                        }
                                        Navigator.pushNamed(
                                            context, AppRoutes.game,
                                            arguments: levels[index + 1]!);
                                      },
                                      isOpened: index < _store.level,
                                      levelNumber: index + 1),
                                );
                              },
                            ),
                          ),
                    _store.getGameFinished()
                        ? ThreeDimensionButton(
                            height: 60,
                            width: 140,
                            assetPath: null,
                            text: 'Reset',
                            label: 'Reset Game',
                            iconSize: 0,
                            onClick: () async {
                              await _store.resetGame();
                            },
                            backgroundColor: const Color(0xff653E1A),
                            shadowColor: const Color(0xff99846A),
                            isRight: false)
                        : const SizedBox(),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                );
              }),
            ),
          );
  }
}
