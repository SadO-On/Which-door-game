import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'home/home_screen.dart';
import 'locator.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
            title: 'Which door?',
            theme: ThemeData(
              fontFamily: 'Impact',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const HomeScreen());
      },
    );
  }
}
