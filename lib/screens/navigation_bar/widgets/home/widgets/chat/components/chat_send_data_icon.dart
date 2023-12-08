// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';

class ChatSendDataIcon extends StatelessWidget {
  ChatSendDataIcon({super.key, required this.containerHeight});

  double containerHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        ChatCubit cubit = ChatCubit.get(context);
        final Brightness platformBrightness =
            MediaQuery.of(context).platformBrightness;
        final bool isDarkMode = platformBrightness == Brightness.dark;
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                  top: cubit.emojiShowing || cubit.focusNode.hasFocus
                      ? height / 1.8
                      : height / 2.1),
              child: AnimatedContainer(
                curve: Curves.easeInOutCubicEmphasized,
                transformAlignment: Alignment.bottomLeft,
                height: containerHeight,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Coloors.backgroundDark
                      : Coloors.backgroundLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                duration: const Duration(milliseconds: 300),
              ),
            );
          },
        );
      },
    );
  }
}
