import 'package:flutter/material.dart';

import 'three_dimension_button.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget(
      {super.key,
      required this.onBackClicked,
      required this.title,
      required this.fontSize});

  final String title;
  final Function onBackClicked;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
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
              onBackClicked();
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
              color: const Color(0xff653E1A),
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        ),
        const SizedBox()
      ],
    );
  }
}
