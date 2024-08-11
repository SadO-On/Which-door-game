import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaurds_game/data/model/guard.dart';
import 'package:gaurds_game/data/model/guardMood.dart';
import 'package:rive/rive.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IdCardWidget extends StatefulWidget {
  const IdCardWidget({super.key, required this.guard, required this.mood});
  final Guard guard;
  final GuardMood mood;

  @override
  _IdCardWidgetState createState() => _IdCardWidgetState();
}

class _IdCardWidgetState extends State<IdCardWidget>
    with SingleTickerProviderStateMixin {
  late RiveAnimationController _controller;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = SimpleAnimation(widget.guard.asset);

    _bounceController = AnimationController(
      duration: const Duration(
          milliseconds: 600), // Increase duration for full bounce
      vsync: this,
    );

    _bounceAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween(begin: 1.0, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 1.1, end: 1.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 50,
      ),
    ]).animate(_bounceController);
  }

  @override
  void didUpdateWidget(covariant IdCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.mood != widget.mood) {
      _bounceController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Container(
            color: const Color(0xff653E1A),
            height: 20,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: const Color(0xff653E1A),
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      AnimatedBuilder(
                        animation: _bounceAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _bounceAnimation.value,
                            child: child,
                          );
                        },
                        child: SizedBox(
                          width: 78,
                          height: 90,
                          child: RiveAnimation.asset(
                            widget.guard.asset,
                            stateMachines: [getStateMachineName(widget.mood)],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SvgPicture.asset('assets/images/barcode-.svg',
                          semanticsLabel: 'barcode'),
                      Text(
                        widget.guard.id,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          letterSpacing: 4,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Guard ID',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xff653E1A),
                        ),
                      ),
                      Table(
                        children: [
                          TableRow(children: [
                            idCellWidget('ID:', widget.guard.id),
                            idCellWidget(
                                'Age:', '${widget.guard.age} Years old'),
                          ]),
                          TableRow(children: [
                            idCellWidget('Name:', widget.guard.name),
                            idCellWidget('DOE:', widget.guard.expiryDate),
                          ]),
                          TableRow(children: [
                            idCellWidget('Gender:', widget.guard.gender),
                            idCellWidget('Employee ID:', widget.guard.eId),
                          ]),
                          TableRow(children: [
                            idCellWidget(
                                'Nationality:', widget.guard.nationality),
                            idCellWidget('Blood Type:', widget.guard.bloodType),
                          ]),
                          TableRow(children: [
                            idCellWidget('Phone:', widget.guard.phoneNum),
                            idCellWidget('Joined:', widget.guard.joinedDate),
                          ]),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TableCell idCellWidget(String title, String value) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(
                color: Color(0xff653E1A), fontSize: 10, fontFamily: 'Impact'),
            children: [
              TextSpan(
                text: ' $value',
                style: const TextStyle(
                    color: Colors.black, fontSize: 10, fontFamily: 'Inter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getStateMachineName(GuardMood mood) {
    print(mood.name);
    switch (mood) {
      case GuardMood.EVIL:
        return "Evil machine";
      case GuardMood.Angry:
        return "Angry machine";
      case GuardMood.Happy:
        return "Happy machine";
      case GuardMood.MAD:
        return "Mad machine";
      case GuardMood.FRUSTRATION:
        return "Frustration machine";
      case GuardMood.CLEVER:
        return "Clever machine";
      case GuardMood.WISE:
        return "Wise machine";
      case GuardMood.BOARD:
        return "Board machine";
      case GuardMood.LAUGH:
        return "Laugh machine";
      case GuardMood.Calm:
        return "Calm machine";
      case GuardMood.Nervous:
        return "Nervous machine";
      default:
        return "Idle machine";
    }
  }
}
