import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

enum ScreenOrientation {
  portraitOnly,
  landscapeOnly,
  rotating,
}

RouteSettings rotationSettings(
    RouteSettings settings, ScreenOrientation rotation) {
  return RouteSettings(name: settings.name, arguments: rotation);
}

class NavigatorObserverWithOrientation extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    if (previousRoute?.settings.arguments is ScreenOrientation) {
      await _setOrientation(
          previousRoute?.settings.arguments as ScreenOrientation);
    } else {
      await _setOrientation(ScreenOrientation.portraitOnly);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    if (route.settings.arguments is ScreenOrientation) {
      await _setOrientation(route.settings.arguments as ScreenOrientation);
    } else {
      await _setOrientation(ScreenOrientation.portraitOnly);
    }
  }
}

Future _setOrientation(ScreenOrientation orientation) async {
  List<DeviceOrientation> orientations;
  switch (orientation) {
    case ScreenOrientation.portraitOnly:
      orientations = [
        DeviceOrientation.portraitUp,
      ];
      break;
    case ScreenOrientation.landscapeOnly:
      orientations = [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
      break;
    case ScreenOrientation.rotating:
      orientations = [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
      break;
  }
  await SystemChrome.setPreferredOrientations(orientations);
}
