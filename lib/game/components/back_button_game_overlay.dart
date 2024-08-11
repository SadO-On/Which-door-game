import 'package:flutter/material.dart';

import '../../widgets/three_dimension_button.dart';

class BackButtonGameOverlay extends StatelessWidget {
  const BackButtonGameOverlay({super.key});
  static const String overlayName = "back_button";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ThreeDimensionButton(
                  isRight: false,
                  assetPath: 'assets/images/back_arrow.svg',
                  height: 46,
                  width: 46,
                  iconSize: 32,
                  label: 'Back button',
                  shadowColor: const Color(0xffB9B39F),
                  backgroundColor: const Color(0xffE9E4D1),
                  onClick: () {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.pop(context, false);
                    });
                  },
                ),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
