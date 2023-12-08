// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to_action/swipe_to_action.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import 'package:whats_app/core/constant/constant.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/core/constant/statics.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key, required this.snapshot, required this.name});

  String name;
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    ChatCubit cubit = ChatCubit.get(context);

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return SizedBox(
          height: cubit.emojiShowing || cubit.focusNode.hasFocus
              ? cubit.repMessage ? h / 3.1 : h / 2.31
              : h / 1.24,
          child: ListView.builder(
            reverse: true,
            controller: cubit.controller,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var element = snapshot.data!.docs[index];
              bool clipper = index != snapshot.data!.docs.length - 1 &&
                  snapshot.data!.docs[index + 1]["id"] != element["id"];
              bool isSender = element["id"] == Statics.id;
              !isSender ? Statics.consigneeToken = element["token"] : null;
              Timestamp timestamp = element[kTime] as Timestamp;
              DateTime dateTime = timestamp.toDate();
              return Swipeable(
                maxOffset: .4,
                onSwipe: (_) => cubit.onSwipeMessage(
                    element["text"], element["id"], index, element["file"]),
                key: const Key(""),
                dragStartBehavior: DragStartBehavior.start,
                child: Padding(
                  padding: clipper || index == snapshot.data!.docs.length - 1
                      ? const EdgeInsets.only(left: 2, right: 2,)
                      : const EdgeInsets.only(left: 15, right: 15,),
                  child: Align(
                      alignment: isSender
                          ? Alignment.centerRight: Alignment.centerLeft,
                      child: ClipPath(
                          clipper:
                              clipper || index == snapshot.data!.docs.length - 1
                                  ? UpperNipMessageClipperTwo(isSender ? MessageType.SEND : MessageType.RECEIVE)
                                  : null,
                          child: Container(
                              constraints: const BoxConstraints(minHeight: 30,),
                              margin: const EdgeInsets.only(top: 5),
                              padding: EdgeInsets.only(
                                  left: isSender ? 10 : clipper || index == snapshot.data!.docs.length - 1 ? 25 : 10,
                                  right: isSender? clipper ||index == snapshot.data!.docs.length - 1
                                          ? 20 : 6 : 5, top: 2.5, bottom: 2.5),
                              decoration: BoxDecoration(
                                  color: isSender? isDarkMode ? greenLight : Colors.lightGreen.shade100
                                      : isDarkMode ? appBarColor : Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  element["repMessage"] != "" || element["repText"] != ""
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              Container(
                                                margin: const EdgeInsets.only(top: 4,bottom: 6,right: 5),
                                                padding: const EdgeInsets.only(bottom: 2,left: 15,right: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border(
                                                      left: BorderSide(width: 3,
                                                          color: snapshot.data!.docs[index]["repFromMe"]
                                                              ? messageColor : Colors.deepPurpleAccent.shade200)), color: Colors.black12,),
                                                child: Row(
                                                  mainAxisSize:MainAxisSize.min,
                                                  children: [
                                                    Column(
                                                        mainAxisSize:MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            element["repFromMe"]
                                                                ? "You"
                                                                : name,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:FontWeight.w500,
                                                                color: element["repFromMe"]
                                                                    ? messageColor
                                                                    : Colors.deepPurpleAccent.shade200),),
                                                          Text(element['repText'],
                                                            style:const TextStyle(fontSize: 14,),
                                                          ),
                                                        ]),
                                                    element["repMessage"] == ""
                                                        ? const SizedBox()
                                                        : SizedBox(
                                                            height: h / 12,
                                                            width: w / 4,
                                                            child: Image.network(element["repMessage"]))
                                                  ],
                                                ),
                                              ),
                                            ])
                                      : const SizedBox(),
                                  element["file"] != ''
                                      ? Container(
                                          constraints: BoxConstraints(
                                              maxWidth: w / 1.7, minHeight: 27),
                                          child: Image.network(
                                              "${element["file"]}"))
                                      : const SizedBox(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: w / 1.7, minHeight: 27),
                                        child: Text(
                                          isSender
                                              ? "${element["text"]} "
                                              : " ${element["text"]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: isDarkMode
                                                  ? textColor
                                                  : Colors.black87),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: clipper ||index == snapshot.data!.docs.length - 1
                                                ? isSender ? 15 : 5
                                                : 5,
                                            left: isSender ? 2 : 5,
                                            top: element["text"].toString().length.toDouble() / 1.5),
                                        child: Text(
                                          DateFormat.jm().format(dateTime),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11,
                                              color: isDarkMode
                                                  ? Colors.white60
                                                  : Colors.black38),
                                        ),
                                      ),
                                      isSender
                                          ? const Stack(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: Colors.blue,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 3.5),
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 16,
                                                    color: Colors.blue,
                                                  ),
                                                )
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ],
                              )))),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
