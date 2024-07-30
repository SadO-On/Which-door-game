import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    _controller.play();
    _controller.addListener(() {
      if (_controller.value.isCompleted) {
        //TODO navigate to GameScreen
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
    return FutureBuilder(
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
    );
  }
}
