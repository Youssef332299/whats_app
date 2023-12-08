// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app/core/text/text_style.dart';
import 'package:whats_app/screens/navigation_bar/components/tab_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, required this.tapController});

  TabController tapController;

  @override
  Widget build(BuildContext context) {

    return AppBar(
        leadingWidth: 10,
        elevation: 0,
        leading: const SizedBox(),
        title: const CustomText(text: "WhatsApp", size: 24),
        actions: action,
        bottom: CustomTabBar(
          tapController: tapController,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(95);
}

List<Widget> action = [
  IconButton(
      onPressed: () async {
        await ImagePicker().pickImage(source: ImageSource.gallery);
      },
      icon: const Icon(Iconsax.camera4)),
  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
  IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
];
