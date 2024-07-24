import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThreeDimensionButton extends StatefulWidget {
  const ThreeDimensionButton(
      {super.key,
      required this.height,
      required this.width,
      required this.assetPath,
      required this.label,
      required this.iconSize,
      required this.onClick,
      required this.backgroundColor,
      required this.shadowColor,
      this.text = '',
      required this.isRight});

  final double height;
  final String? assetPath;
  final String label;
  final String text;
  final double width;
  final Color backgroundColor;
  final Color shadowColor;
  final double iconSize;
  final Function onClick;
  final bool isRight;
  @override
  State<ThreeDimensionButton> createState() => _ThreeDimensionButtonState();
}

class _ThreeDimensionButtonState extends State<ThreeDimensionButton> {
  double _positionRight = 3;
  double _positionBottom = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTapUp: (_) {
            setState(() {
              _positionRight = 3;
              _positionBottom = 3;
              widget.onClick();
            });
          },
          onTapDown: (_) {
            setState(() {
              _positionRight = 0;
              _positionBottom = 0;
            });
          },
          onTapCancel: () {
            setState(() {
              _positionRight = 3;
              _positionBottom = 3;
            });
          },
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                        color: widget.shadowColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(1))),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeIn,
                  right: widget.isRight ? _positionRight : _positionRight * -1,
                  bottom: _positionBottom,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(1))),
                    child: widget.assetPath != null
                        ? SvgPicture.asset(widget.assetPath!,
                            fit: BoxFit.scaleDown,
                            width: widget.iconSize,
                            height: widget.iconSize,
                            semanticsLabel: widget.label)
                        : Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.text,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: 'IMFellDoublePica'),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
