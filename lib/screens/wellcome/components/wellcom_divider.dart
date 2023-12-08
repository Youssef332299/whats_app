// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../core/colors/app_colors.dart';

class WellcomDivider extends StatelessWidget {
  WellcomDivider(
      {super.key,
      required this.text,
      required this.inkWell,
      required this.inkwellText});

  String? text;
  String? inkwellText;
  Function? inkWell;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: w / 11, right: w / 35),
          width: w / 5.5,
          height: 1.5,
          color: Colors.grey.shade400,
        ),
        Text("$text",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            )),
        InkWell(
          onTap: () => inkWell!(),
          child: Text("$inkwellText",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: messageColor)),
        ),
        Container(
          margin: EdgeInsets.only(left: w / 35),
          width: w / 5.5,
          height: 1.5,
          color: Colors.grey.shade400,
        ),
      ],
    );
  }
}
