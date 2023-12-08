// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.icon, required this.onTap});
  Function onTap;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    double h = MediaQuery.of(context).size.height;
    return MaterialButton(
      height: h / 15,
      minWidth: 40,
      onPressed: () => onTap(),
      elevation: 15,
      color: messageColor,
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: messageColor, width: 4),
          borderRadius: BorderRadius.circular(18)),
      child: Icon(icon,color: isDarkMode
          ? Coloors.backgroundDark
          : Coloors.backgroundLight,),
    );
  }
}
