// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class WellComeButton extends StatelessWidget {
  WellComeButton({super.key, required this.onTap, required this.text});

  String? text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 20,
      splashColor: Colors.white,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(color: messageColor,width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      onPressed: onTap,
      height: 40,
      minWidth: MediaQuery.of(context).size.width / 1.2,
      color: messageColor,
      child: Text(
        "$text",
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white),
      ),
    );
  }
}
