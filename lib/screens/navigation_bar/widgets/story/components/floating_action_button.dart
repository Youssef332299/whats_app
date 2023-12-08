import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:whats_app/screens/navigation_bar/components/custom_button.dart';

import '../../../../../core/colors/app_colors.dart';

// ignore: must_be_immutable
class CustomFloatingActionButton extends StatefulWidget {
  CustomFloatingActionButton(
      {super.key, required this.index, required this.onTapCamera, required this.onTapPen});

  Function onTapCamera;
  Function onTapPen;
  int index;

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

late AnimationController animationController;
late Animation<Offset> slidingAnimation;

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton>
    with TickerProviderStateMixin {
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 100));
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, .7), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedBuilder(
              animation: slidingAnimation,
              builder: (context, _) {
                return SlideTransition(
                    position: slidingAnimation,
                    child: MaterialButton(
                      height: height / 20,
                      minWidth: 28,
                      onPressed: () => widget.onTapPen(),
                      elevation: 10,
                      color: const Color(0xFF94F3DC),
                      shape: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(
                                0xFF94F3DC,
                              ),
                              width: 4),
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(
                        Iconsax.brush_4,
                        size: 15,
                        color: isDarkMode
                            ? Coloors.backgroundDark
                            : Coloors.backgroundLight,
                      ),
                    ));
              }),
          SizedBox(
            height: height / 50,
          ),
          CustomButton(icon: Icons.camera_alt_rounded, onTap: widget.onTapCamera,)
        ],
      ),
    );
  }
}
