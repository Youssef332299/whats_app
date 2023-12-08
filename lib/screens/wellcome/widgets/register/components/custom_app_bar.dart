import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class CustomProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDarkMode
      ? backgroundColor
      : Colors.white,
        // leadingWidth: 10,
        elevation: 0,
        centerTitle: true,
        leading: const SizedBox(),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert,color: Colors.black54,),
            // color: Colors.black54,
            itemBuilder: (context) => [
            const PopupMenuItem(
                child: Text("Help"))
          ],)
        ],
        title: const Text(
          "Profile info",
          style: TextStyle(fontSize: 20, color: messageColor,),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
