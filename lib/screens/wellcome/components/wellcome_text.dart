import 'package:flutter/material.dart';

class WellComeText extends StatelessWidget {
  const WellComeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Welcome to whatsapp",
          style: TextStyle(
            fontSize: 26.2,
            fontWeight: FontWeight.w500,
            // color: Colors.white
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5,),
          child: RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                    text: "Read our ",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(color: Colors.blueAccent)),
                  TextSpan(
                    text: ".",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  TextSpan(
                    text: ' Tap "Agree and continue" to',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ]),
          ),
        ),
        RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: "accept the ",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
               const TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(color: Colors.blueAccent)),
                TextSpan(
                  text: ".",
                  style: TextStyle(color: Colors.grey.shade600),
                ),

              ]),
        ),
      ],
    );
  }
}
