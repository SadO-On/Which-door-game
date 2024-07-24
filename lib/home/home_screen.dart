import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaurds_game/widgets/three_dimension_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final Uri _url = Uri.parse('https://www.98s.studio/');

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDE3D4),
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
                    onClick: () {},
                    backgroundColor: const Color(0xff653E1A),
                    shadowColor: const Color(0xff99846A),
                    isRight: false),
                SvgPicture.asset('assets/images/right_door.svg',
                    semanticsLabel:
                        'Image of dark brown door in the right of the screen')
              ],
            ),
            GestureDetector(
              onTap: () async {
                try {
                  await _launchUrl();
                } catch (error) {
                  //Log it
                }
              },
              child: SvgPicture.asset('assets/images/98sLogo.svg',
                  semanticsLabel: '98\'s Logo'),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
