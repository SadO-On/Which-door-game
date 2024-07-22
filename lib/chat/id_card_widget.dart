import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rich_typewriter/rich_typewriter.dart';

class IdCardWidget extends StatelessWidget {
  const IdCardWidget({super.key});

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
                      SvgPicture.asset('assets/images/SteveImage.svg',
                          semanticsLabel: 'Steve Image'),
                      const SizedBox(
                        height: 8,
                      ),
                      Image(
                          width: Adaptive.px(84),
                          image: const AssetImage('assets/images/barcode.png')),
                      const Text(
                        '6 0 2 9 8 3 9 8 3 2',
                        style: TextStyle(fontFamily: 'Inter', fontSize: 10),
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
                            idCellWidget('ID:', '345678'),
                            idCellWidget('Age:', '33 Years old'),
                          ]),
                          TableRow(children: [
                            idCellWidget('Name:', 'Steve'),
                            idCellWidget('DOE:', '01/12/2029'),
                          ]),
                          TableRow(children: [
                            idCellWidget('Gender:', 'Male'),
                            idCellWidget('Employee ID:', '45633'),
                          ]),
                          TableRow(children: [
                            idCellWidget('Nationality:', 'Quarls'),
                            idCellWidget('Blood Type:', 'O+'),
                          ]),
                          TableRow(children: [
                            idCellWidget('Phone:', '+99 012 345 6789'),
                            idCellWidget('Joined:', '09/04/2020'),
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
