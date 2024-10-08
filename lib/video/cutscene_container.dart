import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import '../data/model/level.dart';
import '../data/storage_repository.dart';
import '../game/components/loading_screen.dart';
import '../game/game_play_container.dart';
import '../locator.dart';
import '../utils/routes.dart';
import '../widgets/three_dimension_button.dart';

class CutSceneContainerScreen extends StatefulWidget {
  CutSceneContainerScreen({super.key, required this.videoAsset});
  final String videoAsset;
  final StorageRepository _storageRepository = getIt.get<StorageRepository>();
  @override
  State<CutSceneContainerScreen> createState() =>
      _CutSceneContainerScreenState();
}

class _CutSceneContainerScreenState extends State<CutSceneContainerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.videoAsset);

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    _controller.addListener(() async {
      if (_controller.value.isCompleted) {
        await widget._storageRepository.setFirstTime();
        if (widget._storageRepository.getLevel() == 7) {
          await widget._storageRepository.setFinishTheGame();
        }
        if (mounted) {
          if (widget._storageRepository.getLevel() == 7) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
            return;
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GamePlayContainer(level: levels[1]!)));
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const LoadingScreen();
                }
              },
            ),
            widget._storageRepository.isFirstTime() &&
                    !widget._storageRepository.isFinishTheGame()
                ? Container()
                : Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ThreeDimensionButton(
                          height: 48,
                          width: 116,
                          assetPath: null,
                          text: 'SKIP',
                          label: 'Skip the scene',
                          iconSize: 0,
                          onClick: () {
                            if (widget._storageRepository.getLevel() == 7) {
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName(AppRoutes.home));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GamePlayContainer(
                                          level: levels[1]!)));
                            }
                          },
                          backgroundColor: const Color(0xff653E1A),
                          shadowColor: const Color(0xff99846A),
                          isRight: false),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
