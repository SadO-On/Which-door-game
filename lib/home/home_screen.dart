import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaurds_game/utils/routes.dart';
import 'package:gaurds_game/widgets/three_dimension_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final Uri _studio_url = Uri.parse('https://www.98s.studio/');
final Uri _gemini_url = Uri.parse('https://gemini.google.com/');

class _HomeScreenState extends State<HomeScreen> {
  final _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset('assets/images/Which_door_text.svg',
                semanticsLabel: 'Game title (Which Door?)'),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/left_door.svg',
                    semanticsLabel:
                        'Image of brown door in the left of the screen'),
                ThreeDimensionButton(
                    height: 48,
                    width: 116,
                    assetPath: null,
                    text: 'OPEN',
                    label: 'Start the game',
                    iconSize: 0,
                    onClick: () async {
                      await _player.play(AssetSource('audio/start game.wav'));

                      Future.delayed(const Duration(milliseconds: 200), () {
                        Navigator.pushNamed(context, AppRoutes.level);
                      });
                    },
                    backgroundColor: const Color(0xff653E1A),
                    shadowColor: const Color(0xff99846A),
                    isRight: false),
                SvgPicture.asset('assets/images/right_door.svg',
                    semanticsLabel:
                        'Image of dark brown door in the right of the screen')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      await _launchUrl(_studio_url);
                    } catch (error) {
                      //Log it
                    }
                  },
                  child: SvgPicture.asset('assets/images/98sLogo.svg',
                      width: 90, height: 50, semanticsLabel: '98\'s Logo'),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      await _launchUrl(_gemini_url);
                    } catch (error) {
                      //Log it
                    }
                  },
                  child: Image.asset(
                    'assets/images/gemini.png',
                    width: 90,
                    height: 50,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
