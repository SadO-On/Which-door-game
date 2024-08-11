import 'package:flutter/material.dart';
import 'package:gaurds_game/utils/theme.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  static const String overlayName = "loading";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Lottie.asset(
            'assets/lottie/loading.json',
            width: 130,
            height: 265,
            fit: BoxFit.scaleDown,
          ),
          const Text(
            "Loading....",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'IMFellDoublePica', fontSize: 26),
          )
        ],
      ),
    );
  }
}
