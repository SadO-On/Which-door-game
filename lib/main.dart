import 'dart:io';

import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/game/game_play_container.dart';
import 'package:gaurds_game/level/level_screen.dart';
import 'package:gaurds_game/video/cutscene_container.dart';
import 'home/home_screen.dart';
import 'locator.dart';
import 'utils/orientation_helpers.dart';
import 'utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupGetIt();

  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _observer = NavigatorObserverWithOrientation();

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.splash) {
      return MaterialPageRoute(
        builder: (context) => FlameSplashScreen(
            showBefore: (context) {
              return SvgPicture.asset(
                width: 166,
                height: 157,
                'assets/images/98s_studio.svg',
                semanticsLabel: '98\'s Studio Logo',
              );
            },
            onFinish: (BuildContext context) => Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.home,
                ),
            theme: FlameSplashTheme.white),
        settings: rotationSettings(settings, ScreenOrientation.portraitOnly),
      );
    }

    if (settings.name == AppRoutes.home) {
      return PageRouteBuilder(
          pageBuilder: (context, __, ___) => const HomeScreen(),
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          settings: rotationSettings(settings, ScreenOrientation.portraitOnly));
    } else if (settings.name == AppRoutes.level) {
      return MaterialPageRoute(
        builder: (context) => LevelScreen(),
        settings: rotationSettings(settings, ScreenOrientation.portraitOnly),
      );
    } else if (settings.name == AppRoutes.cutScene) {
      return MaterialPageRoute(
        builder: (context) => CutSceneContainerScreen(
          videoAsset: settings.arguments! as String,
        ),
        settings: rotationSettings(settings, ScreenOrientation.landscapeOnly),
      );
    } else if (settings.name == AppRoutes.game) {
      return MaterialPageRoute(
        builder: (context) => GamePlayContainer(
          level: settings.arguments! as Level,
        ),
        settings: rotationSettings(settings, ScreenOrientation.landscapeOnly),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Which door?',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Impact',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        }),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _onGenerateRoute,
      navigatorObservers: [_observer],
    );
  }
}



// FlameSplashScreen(
//             showBefore: (context) {
//               return SvgPicture.asset(
//                 width: 166,
//                 height: 157,
//                 'assets/images/98s_studio.svg',
//                 semanticsLabel: '98\'s Studio Logo',
//               );
//             },
//             onFinish: (BuildContext context) => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomeScreen()),
//                 ),
//             theme: FlameSplashTheme.white)

