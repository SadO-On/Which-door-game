import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/game_play_container.dart';
import 'package:gaurds_game/widgets/three_dimension_button.dart';
import 'package:video_player/video_player.dart';

class CutSceneContainerScreen extends StatefulWidget {
  const CutSceneContainerScreen({super.key, required this.videoAsset});
  final String videoAsset;

  @override
  State<CutSceneContainerScreen> createState() =>
      _CutSceneContainerScreenState();
}

class _CutSceneContainerScreenState extends State<CutSceneContainerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = VideoPlayerController.asset(widget.videoAsset);

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    _controller.addListener(() {
      if (_controller.value.isCompleted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => GamePlayContainer(level: levels[1]!)));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Positioned(
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GamePlayContainer(level: levels[1]!)));
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
