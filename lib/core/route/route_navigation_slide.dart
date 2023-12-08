import 'package:flutter/cupertino.dart';

Route buildRoute(Widget screen) {
  return PageRouteBuilder(
    reverseTransitionDuration: const Duration(milliseconds: 210),
    transitionDuration: const Duration(milliseconds: 210),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0,0.0);
      const end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      final slide = animation.drive(tween);
      return SlideTransition(
        position: slide,
        child: child,
      );
    },
  );
}
