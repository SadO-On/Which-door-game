import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LevelButtonWidget extends StatelessWidget {
  const LevelButtonWidget(
      {super.key,
      required this.isOpened,
      required this.levelNumber,
      required this.onClick});

  final bool isOpened;
  final int levelNumber;
  final Function(int index) onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(levelNumber);
      },
      child: SvgPicture.asset(
        'assets/images/level_$levelNumber.svg',
        semanticsLabel: 'Level $levelNumber',
        colorFilter: isOpened
            ? null
            : const ColorFilter.mode(Color(0xff777777), BlendMode.color),
      ),
    );
  }
}
