// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import 'package:whats_app/data/model/user_data_model.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';

class ChatTextFiled extends StatelessWidget {
  ChatTextFiled({super.key, required this.documentId, required this.data});

  UserDataModel data;
  String documentId;

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
              left: 8.0,
              top: cubit.emojiShowing || cubit.focusNode.hasFocus
                  ? MediaQuery.of(context).size.height / 2.3
                  : MediaQuery.of(context).size.height / 1.23),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                maxLines: 200,
                minLines: 1,
                cursorColor: messageColor,
                focusNode: cubit.focusNode,
                textDirection: TextDirection.ltr,
                style: const TextStyle(fontSize: 17),
                controller: cubit.textEditingController,
                onTap: () => cubit.onTapTextField(),
                onChanged: (_) => cubit.onChanged(),
                decoration: InputDecoration(
                  fillColor: !isDarkMode
                      ? Coloors.backgroundLight
                      : Coloors.backgroundDark,
                  filled: true,
                  isDense: false,
                  hintText: "Message",
                  hintTextDirection: TextDirection.ltr,
                  suffixIcon: GestureDetector(
                    onTap: () => cubit.onTapEmojiIcon(),
                    child: Icon(
                      cubit.emojiShowing != false
                          ? Icons.keyboard
                          : isDarkMode
                              ? Icons.tag_faces_rounded
                              : Icons.tag_faces,
                      color: isDarkMode ? greyLight : Colors.black38,
                    ),
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () => cubit.getImageFromGallery(documentId, data.email, context),
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            color: greyLight,
                          )),
                      GestureDetector(
                          onTap: () => cubit.sendFile(),
                          child: const Icon(
                            Icons.attach_file,
                            color: greyLight,
                          )),
                    ],
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: GestureDetector(
                        onTap: () => cubit.onSend(documentId, data.email!, context),
                        child: CircleAvatar(
                            backgroundColor: greenDark,
                            radius: 26,
                            child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Icon(
                                  cubit.send || cubit.message != ''
                                      ? Icons.send_outlined
                                      : Iconsax.microphone_25,
                                  color: Colors.white,
                                )))),
                  ),
                  contentPadding: const EdgeInsets.only(top: 30),
                  hintStyle: TextStyle(
                      fontSize: 17,
                      color: isDarkMode ? Colors.white54 : Colors.black26),
                  border:
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                  ),
                ),
              )),
        );
      },
    );
  }
}
