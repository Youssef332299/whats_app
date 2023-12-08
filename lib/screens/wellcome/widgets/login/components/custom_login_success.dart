// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import 'package:whats_app/core/widgets/circle_progras_indicator.dart';
import 'package:whats_app/screens/wellcome/components/wellcom_divider.dart';
import 'package:whats_app/screens/wellcome/components/wellcome_button.dart';
import 'package:whats_app/screens/wellcome/components/wellcome_image.dart';
import 'package:whats_app/screens/wellcome/components/wellcome_text_filed.dart';
import 'package:whats_app/screens/wellcome/widgets/register/register_screen.dart';

class CustomLoginSuccess extends StatelessWidget {
  CustomLoginSuccess({super.key, required this.cubit});

  dynamic cubit;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: h / 12,),
          const WellcomeImage(),
          Padding(
            padding: EdgeInsets.only(right: w / 1.6, bottom: 10, top: 10),
            child: Text("Login".toUpperCase(),
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: messageColor)),
          ),
          WellcomeTextFiled(
              controller: cubit.email,
              hintMessage: "Email",
              icon: Icons.email_outlined),
          WellcomeTextFiled(
              controller: cubit.pass,
              hintMessage: "Password",
              icon: Iconsax.lock),
          SizedBox(height: h/20,),
          cubit.isLoading != true
              ? WellComeButton(onTap: () => cubit.loginUser(cubit.email.text, cubit.pass.text), text: "Login")
              : loading(),
          SizedBox(height: h/20,),
          WellcomDivider(text: "Create account  ",
              inkWell: ()=> Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterScreen(),)),
              inkwellText: "Sign up"),
        ],
      ),
    );
  }
}
