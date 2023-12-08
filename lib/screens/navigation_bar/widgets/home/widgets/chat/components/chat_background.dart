import 'package:flutter/material.dart';

import '../../../../../../../core/assets/images/images.dart';

class ChatBackGround extends StatelessWidget {
  const ChatBackGround({super.key});

  @override
  Widget build(BuildContext context) {

    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    return Image(
      height: double.maxFinite,
      width: double.maxFinite,
      fit: BoxFit.cover,
      color: isDarkMode
          ? Colors.white12
          : Colors.black12,
      image: AssetImage(Images.doodle),
    );
  }
}
