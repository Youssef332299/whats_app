// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/core/constant/statics.dart';
import 'package:whats_app/core/text/text_style.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/chat_screen.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';
import '../../../../../core/constant/constant.dart';
import '../../../../../core/route/route_navigation_slide.dart';
import '../../../../../data/model/user_data_model.dart';
import '../../../../core/bloc/multi_bloc_provider.dart';

class HomeListView extends StatelessWidget {
  HomeListView({super.key, required this.snapshot});

  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          var element = snapshot.data!.docs[index];
          Timestamp lastSeenTime = element['lastSeen'] as Timestamp;
          DateTime lastSeen = lastSeenTime.toDate();

          if (element["email"] == Statics.id) {
            return const SizedBox();
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  context.read<ChatCubit>().endChat();
                  Statics.chatName = element['name'];
                  Statics.consigneeToken = element['userAppToken']!;
                  Timestamp lastSeenTime = element['lastSeen'] as Timestamp;
                  Timestamp createdAtTime = element['createdAt'] as Timestamp;
                  DateTime lastSeen = lastSeenTime.toDate();
                  DateTime createdAt = createdAtTime.toDate();
                  Navigator.of(context).push(buildRoute(ChatScreen(
                    data: UserDataModel(
                      name: element['name'],
                      image: element['image'],
                      userAppToken: element['userAppToken'],
                      email: element['email'],
                      createdAt: createdAt,
                      status: element['status'],
                      lastSeen: lastSeen,
                      isOnline: element['isOnline'],
                    ),
                    documentId: "${element['documentId']}",
                    isInChat: element['haveNewMessage'],
                  )));
                  // fireStore.collection(Statics.id).doc(Statics.id).collection(kHomeUser)
                  //     .doc(element['documentId']).update({"haveNewMessage": false, "isInChat": true});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black12,
                      backgroundImage: NetworkImage(element['image']!),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: width / 1.6,
                          child: Text(
                                    element['name']!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                 ),
                        ),
                        SizedBox(
                            width: width / 1.6,
                            child: Text(
                              element['lastMessage'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey),
                            )),
                      ],
                    ),
                    Container(
                        child: element['haveNewMessage']
                            ? Column(
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(DateTime.now())
                                  == DateFormat('yyyy-MM-dd').format(lastSeen)
                                  ? DateFormat.jm().format(lastSeen)
                                  : DateFormat.EEEE().format(lastSeen),
                              // text: "${i.createdAt}",
                              style: const TextStyle(fontSize: 11,color: CupertinoColors.systemGreen),
                            ),
                            const SizedBox(height: 8,),
                            const CircleAvatar(backgroundColor: CupertinoColors.systemGreen, radius: 6,),
                          ],
                        )
                        // : Statics.homeNotification[index]["messageLength"] != 0
                        //     ? CircleAvatar(
                        //         backgroundColor:
                        //             CupertinoColors.systemGreen,
                        //         radius: 8,
                        //         child: Text(Statics.homeNotification[index]["messageLength"]),
                        //       )
                            : Column(
                          children: [
                            CustomText(
                              text: DateFormat('yyyy-MM-dd').format(DateTime.now())
                                  == DateFormat('yyyy-MM-dd').format(lastSeen)
                                  ? DateFormat.jm().format(lastSeen)
                                  : DateFormat.EEEE().format(lastSeen),
                              // text: "${i.createdAt}",
                              size: 11,
                            ),
                            const SizedBox(height: 15,),
                          ],
                        )
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
