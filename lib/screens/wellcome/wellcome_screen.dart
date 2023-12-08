import 'package:flutter/material.dart';
import 'package:whats_app/core/constant/statics.dart';
import 'package:whats_app/screens/wellcome/components/language_container.dart';
import 'package:whats_app/screens/wellcome/components/wellcome_button.dart';
import 'package:whats_app/screens/wellcome/components/wellcome_image.dart';
import 'package:whats_app/screens/wellcome/components/wellcome_text.dart';
import 'package:whats_app/screens/wellcome/widgets/register/register_screen.dart';

class WellComeScreen extends StatelessWidget {
  const WellComeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: h / 12,),
            const WellcomeImage(),
            const WellComeText(),
            SizedBox(height: h / 20,),
            const LanguageContainer(),
            SizedBox(height: h / 4.6,),
            WellComeButton(
            onTap: () {
              Statics().initNotification();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),));},
                text: "Agree and continue"
            ),
          ],
        ),
      ),
    );
  }
}