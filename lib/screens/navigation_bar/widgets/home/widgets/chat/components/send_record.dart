import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class SendRecord extends StatelessWidget {
  const SendRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: tabColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.microphone_25)),
    );
  }
}
