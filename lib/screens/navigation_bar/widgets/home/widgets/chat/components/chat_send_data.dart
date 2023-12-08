import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';
import '../../../../../../../core/colors/app_colors.dart';

class ChatSendData extends StatelessWidget {
  ChatSendData({super.key, required this.selectedImage, required this.docID, required this.id});

  File selectedImage;
  String id;
  String docID;

  @override
  Widget build(BuildContext context) {
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: Colors.black,
            height: height,
            width: width,
            child: Stack(
              children: [
                Center(child: Image.file(selectedImage)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: context
                              .watch<ChatCubit>()
                              .textEditingController,
                          maxLines: 200,
                          minLines: 1,
                          cursorColor: messageColor,
                          decoration: InputDecoration(
                            fillColor: !isDarkMode
                                ? Coloors.backgroundLight
                                : Coloors.backgroundDark,
                            filled: true,
                            isDense: false,
                            hintText: "Message",
                            contentPadding: const EdgeInsets.only(left: 30),
                            hintStyle: TextStyle(
                                fontSize: 17,
                                color: isDarkMode ? Colors.white54 : Colors
                                    .black26),
                            border:
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  style: BorderStyle.none, width: 0),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            context.read<ChatCubit>().imageScreen = true;
                            context.read<ChatCubit>().onSend(docID, id, context);
                          },
                          icon: const Align(
                            alignment: Alignment.centerRight,
                            child: CircleAvatar(
                                backgroundColor: greenDark,
                                radius: 26,
                                child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Icon(
                                      Icons.send_outlined, color: Colors.white,
                                    ))),
                          )),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
