// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/constant/constant.dart';
import 'package:whats_app/core/constant/statics.dart';
import 'package:whats_app/data/model/user_data_model.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/components/chat_background.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/components/chat_send_data_icon.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/components/chat_text_field.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/components/chat_rep.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/components/chat_view.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/components/emoji_widget.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/components/loading_chat_widget.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';
import '../../../../../../core/colors/app_colors.dart';
import 'components/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.data, required this.documentId, required this.isInChat});

  UserDataModel data;
  String documentId;
  bool isInChat;

  @override
  Widget build(BuildContext context) {

    ChatCubit cubit = ChatCubit.get(context);
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    cubit.isInChat = isInChat;
    Statics.chatId = data.name!;

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return StreamBuilder<QuerySnapshot>(
          stream: cubit.getMessages(data.email),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              CollectionReference users = FirebaseFirestore.instance.collection(kUsers);
              return StreamBuilder<QuerySnapshot>(
                stream: users.snapshots(),
                builder: (context, snapshotAppBar){
                CollectionReference lastMessage = FirebaseFirestore.instance.collection(data.email!).doc(data.email).collection(kHomeUser);
                  return StreamBuilder<QuerySnapshot>(
                    stream: lastMessage.snapshots(),
                    builder: (context, lastMessageSnapshot) {
                      lastMessageSnapshot.hasData ? cubit.getDocumentId(lastMessageSnapshot): null;
                      return Scaffold(
                          backgroundColor: isDarkMode
                              ? backgroundDark
                              : const Color(0xFFFFEECC),
                          appBar: snapshotAppBar.hasData
                              ? CustomChatAppBar(snapshot: snapshotAppBar, data: data)
                              : AppBar(),
                          body: Stack(
                            children: [
                              const ChatBackGround(),
                              ChatView(snapshot: snapshot, name: data.name!,),
                              ChatRep(data: data),
                              ChatTextFiled(documentId: documentId, data: data,),
                              const SizedBox(height: 10,),
                              cubit.emojiShowing
                                  ? EmojisWidget(addEmojiToTextController: cubit.addEmojiToTextController)
                                  : const SizedBox(),
                              ChatSendDataIcon(containerHeight: cubit.isSendFile ? 280 : 0),
                            ],
                          ));
                    }
                  );
                }
              );
            } else {
              return const LoadingChatWidget();
            }
          },
        );
      },
    );
  }
}
