import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/theme.dart';
import '../../widgets/three_dimension_button.dart';

class PopupContainerWidget extends StatelessWidget {
  const PopupContainerWidget(
      {super.key,
      required this.asset,
      required this.btnText,
      required this.isAnimation,
      required this.onClick,
      required this.height,
      required this.width,
      required this.text});

  final bool isAnimation;
  final String asset;
  final String text;
  final double? width;
  final double? height;
  final String btnText;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset('assets/images/pop-up.svg',
                  semanticsLabel: 'Pop up screen'),
              Column(
                children: [
                  SvgPicture.asset(
                    asset,
                    semanticsLabel: text,
                    width: width,
                    height: height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      text,
                      style: const TextStyle(
                          fontFamily: secondaryFontFamily, fontSize: 16),
                    ),
                  ),
                  ThreeDimensionButton(
                      height: 24,
                      width: 100,
                      assetPath: null,
                      text: btnText,
                      fontSize: 10,
                      label: 'Start the game',
                      iconSize: 0,
                      onClick: () {
                        Future.delayed(const Duration(milliseconds: 200), () {
                          onClick();
                        });
                      },
                      backgroundColor: const Color(0xff653E1A),
                      shadowColor: const Color(0xff99846A),
                      isRight: true)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
