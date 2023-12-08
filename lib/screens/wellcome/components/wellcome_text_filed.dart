import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class WellcomeTextFiled extends StatelessWidget {
  WellcomeTextFiled({
    super.key,
    required this.controller,
    required this.hintMessage,
    required this.icon,
  });

  String? hintMessage;
  IconData icon;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 40, bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintMessage,
          icon: Icon(icon, color: messageColor, shadows: const [
            Shadow(
                offset: Offset(2, 0),
                blurRadius: 3,
                color: Colors.black54)
          ]),
          focusColor: messageColor,
          iconColor: Colors.white,
          fillColor: Colors.green,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: messageColor)),
        ),
      ),
    );
  }
}
