import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/screens/wellcome/widgets/register/widgets/components/info_emojis_widget.dart';
import 'package:whats_app/screens/wellcome/widgets/register/widgets/components/next_button.dart';
import 'package:whats_app/screens/wellcome/widgets/register/widgets/components/profile_circle_avatar.dart';
import 'package:whats_app/screens/wellcome/components/register_text_field.dart';
import 'package:whats_app/screens/wellcome/widgets/register/components/custom_app_bar.dart';
import 'package:whats_app/screens/wellcome/widgets/register/cubit/register_cubit.dart';
import '../../../../navigation_bar/widgets/home/widgets/chat/components/emoji_widget.dart';


class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = RegisterCubit.get(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomProfileAppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileAvatar(),
                const RegisterTextField(),
                SizedBox(
                  height: cubit.focusNode.hasFocus || cubit.emojiShowing
                      ? MediaQuery.of(context).size.height / 4.7
                      : MediaQuery.of(context).size.height / 1.7,
                ),
                const NextButton(),
                const SizedBox(height: 20,),
                cubit.emojiShowing
                    ? InfoEmojisWidget(addEmojiToTextController: cubit.addEmojiToTextController)
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
