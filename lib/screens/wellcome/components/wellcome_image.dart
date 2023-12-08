import 'package:flutter/cupertino.dart';

import '../../../core/colors/app_colors.dart';

class WellcomeImage extends StatelessWidget {
  const WellcomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      "assets/images/circle.png",
      scale: 1.9,
      color: tabColor,
    ));
  }
}
