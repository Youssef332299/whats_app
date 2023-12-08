// ignore_for_file: must_be_immutable
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import 'package:whats_app/core/constant/statics.dart';
import 'package:whats_app/data/model/user_data_model.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';

class ChatRep extends StatelessWidget {
  ChatRep({super.key, required this.data});

  UserDataModel data;

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;

    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;

      return AnimatedContainer(
        constraints: BoxConstraints(
          maxHeight: cubit.repMessage ? 120 : 0,
        ),
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.topCenter,
        onEnd: () => cubit.onAnimatedEnd(),
        margin: EdgeInsets.only(
            left: 8.0,
            // bottom: 42,
            top: cubit.emojiShowing || cubit.focusNode.hasFocus
                ? MediaQuery.of(context).size.height / 3
                : MediaQuery.of(context).size.height / 1.4),
        width: width / 1.26,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: !isDarkMode ? Coloors.backgroundLight : Coloors.backgroundDark,
        ),
        child: cubit.animatedRepContainerEnd
            ? container(width, context, cubit)
            : const SizedBox(),
      );
    });
  }

  Widget container(double width, BuildContext context, ChatCubit cubit) {
    return Container(
        // height: ,
        width: width / 1.3,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
        padding: const EdgeInsets.only(top: 1, left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border(
              left: BorderSide(
                  width: 3,
                  color: context.watch<ChatCubit>().messageId == Statics.id
                      ? messageColor
                      : Colors.deepPurpleAccent.shade200)),
          color: Colors.black12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 189,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        context.watch<ChatCubit>().messageId == Statics.id
                            ? "You"
                            : data.name!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: context.watch<ChatCubit>().messageId == Statics.id
                                ? messageColor
                                : Colors.deepPurpleAccent.shade200),
                      ),
                    ),
                    Container(
                      height: 40,
                      // constraints: const BoxConstraints(maxHeight: 40),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        context.watch<ChatCubit>().textRep,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () => cubit.onTapCancelRep(),
                  child: Container(
                    height: 70,
                    width: 85,
                    alignment: Alignment.topRight,
                    decoration: context.watch<ChatCubit>().messageRep != '' ?
                    BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(context.watch<ChatCubit>().messageRep)))
                        : const BoxDecoration(),
                    child: cubit.repMessage
                    ? const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 20,
                    ) : const SizedBox(),
                  )),

            ],
          ),
        );
  }
}
