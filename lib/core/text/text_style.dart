import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;

  const CustomText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
