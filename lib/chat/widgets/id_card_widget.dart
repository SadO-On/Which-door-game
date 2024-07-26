import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaurds_game/data/model/guard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rich_typewriter/rich_typewriter.dart';

class IdCardWidget extends StatelessWidget {
  const IdCardWidget({super.key, required this.guard});
  final Guard guard;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
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
                      SvgPicture.asset(guard.imageAsset,
                          semanticsLabel: '${guard.name}\'s Image'),
                      const SizedBox(
                        height: 8,
                      ),
                      Image(
                          width: Adaptive.px(84),
                          image: const AssetImage('assets/images/barcode.png')),
                      Text(
                        guard.id,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            letterSpacing: 4),
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
                            idCellWidget('ID:', guard.id),
                            idCellWidget('Age:', '${guard.age} Years old'),
                          ]),
                          TableRow(children: [
                            idCellWidget('Name:', guard.name),
                            idCellWidget('DOE:', guard.expiryDate),
                          ]),
                          TableRow(children: [
                            idCellWidget('Gender:', guard.gender),
                            idCellWidget('Employee ID:', guard.eId),
                          ]),
                          TableRow(children: [
                            idCellWidget('Nationality:', guard.nationality),
                            idCellWidget('Blood Type:', guard.bloodType),
                          ]),
                          TableRow(children: [
                            idCellWidget('Phone:', guard.phoneNum),
                            idCellWidget('Joined:', guard.joinedDate),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      )
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
        child: RichTypewriter(
          delay: 75,
          child: RichText(
              text: TextSpan(
                  text: title,
                  style: const TextStyle(
                      color: Color(0xff653E1A),
                      fontSize: 10,
                      fontFamily: 'Impact'),
                  children: [
                TextSpan(
                    text: ' $value',
                    style: const TextStyle(
                        color: Colors.black, fontSize: 10, fontFamily: 'Inter'))
              ])),
        ),
      ),
    );
  }
}
