import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: tabColor,
                  child: Icon(
                    Iconsax.repeate_music,
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: w / 1.88,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Create call link",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    "Share link for you WhatsApp call",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: Colors.grey.shade400
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      );
  }
}
