import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 15, right: 10, bottom: 10),
                child: Container(
                  height: h / 15,
                  width: w / 7,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey.shade100
                        : Colors.black12,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: h / 110,
                          left: w / 38,
                          child: Icon(
                            Icons.groups,
                            size: 36,
                            color: isDarkMode
                                ? Coloors.backgroundDark
                                : Coloors.backgroundLight,
                          )),
                      Positioned(
                          top: h / 27,
                          left: w / 13,
                          child: CircleAvatar(
                            radius: 12.2,
                            backgroundColor: isDarkMode
                                ? Coloors.backgroundDark
                                : Coloors.backgroundLight,
                            child: CircleAvatar(
                              radius: 11,
                              backgroundColor: messageColor,
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: isDarkMode
                                    ? Coloors.backgroundDark
                                    : Coloors.backgroundLight,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const Text("New Community",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 20,
        ),
      ],
    );
  }
}
