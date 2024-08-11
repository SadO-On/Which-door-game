import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/three_dimension_button.dart';

class FInalLevelWidget extends StatelessWidget {
  FInalLevelWidget({super.key, required this.onClicked});
  Function onClicked;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgPicture.asset('assets/images/final_door.svg',
            height: MediaQuery.of(context).size.height * 0.6,
            semanticsLabel: 'Final Door'),
        const SizedBox(
          height: 60,
        ),
        ThreeDimensionButton(
            height: 60,
            width: 140,
            assetPath: null,
            text: 'FINALE',
            label: 'Final level',
            iconSize: 0,
            onClick: () async {
              onClicked();
            },
            backgroundColor: const Color(0xff653E1A),
            shadowColor: const Color(0xff99846A),
            isRight: false)
      ],
    );
  }
}
