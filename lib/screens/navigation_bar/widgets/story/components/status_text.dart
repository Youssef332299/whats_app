import 'package:flutter/material.dart';
import '../../../../../core/text/text_style.dart';

class StatusText extends StatelessWidget {
  const StatusText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(text: "Status", size: 20),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
