import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import '../widgets/register/cubit/register_cubit.dart';

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = RegisterCubit.get(context);

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextFormField(
            onTap: () => cubit.onTapTextField(),
            focusNode: cubit.focusNode,
            controller: cubit.name,
            textDirection: TextDirection.ltr,
            cursorColor: messageColor,
            autofocus: true,
            decoration: InputDecoration(
                hintTextDirection: TextDirection.ltr,
                icon: GestureDetector(
                  onTap: () => cubit.onTapEmojiIcon(),
                  child: Icon(
                    cubit.emojiShowing != false
                        ? Icons.keyboard
                        : Icons.tag_faces_rounded,
                    color: greyLight,
                  ),
                ),
                iconColor: messageColor,
                focusColor: messageColor,
                hintText: "Type your name here",
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: messageColor, width: 2))),
          ),
        ),
      ),
    );
  }
}
