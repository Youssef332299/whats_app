import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/text/text_style.dart';

// ignore: must_be_immutable
class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  CustomTabBar({super.key, required this.tapController});

  TabController tapController;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;

    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      dragStartBehavior: DragStartBehavior.start,
      indicatorWeight: 3,
      isScrollable: true,
      physics: const NeverScrollableScrollPhysics(),
      tabAlignment: TabAlignment.start,

      enableFeedback: true,
      controller: tapController,
      labelColor:  isDarkMode
          ? tabColor
          : Colors.white,
      indicatorColor: isDarkMode
      ? tabColor
      : Colors.white,
      unselectedLabelColor: isDarkMode
        ? Colors.white60
        : Colors.white38,
      tabs: [
        SizedBox(
            height: h / 20,
            width: w * .08,
            child: const Icon(
              Icons.groups,
            )),
        Container(
            height: h / 20,
            width: w * .20,
            alignment: Alignment.center,
            child: const CustomText(text: "Chats", size: 17)),
        Container(
            height: h / 20,
            width: w * .20,
            alignment: Alignment.center,
            child: const CustomText(text: "Updates", size: 17)),
        Container(
            height: h / 20,
            width: w * .20,
            alignment: Alignment.center,
            child: const CustomText(text: "Calls", size: 17)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
