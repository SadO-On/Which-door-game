import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  static const String overlayName = "loading";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Loading",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'IMFellDoublePica', fontSize: 18),
          )
        ],
      ),
    );
  }
}
