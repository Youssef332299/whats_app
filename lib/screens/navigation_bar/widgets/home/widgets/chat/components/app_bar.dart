import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/data/model/user_data_model.dart';

// ignore: must_be_immutable
class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomChatAppBar({super.key, required this.snapshot, required this.data});
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  UserDataModel data;
  int userIndex = 0;

  @override
  Widget build(BuildContext context) {
      for(int i = 0; i < snapshot.data!.docs.length; i++){
        var doc = snapshot.data!.docs[i];
        doc['email'] == data.email ? userIndex = i : null;
      }

      Timestamp lastSeenTime = snapshot.data!.docs[userIndex]['lastSeen'] as Timestamp;
      DateTime lastSeen = lastSeenTime.toDate();

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    return AppBar(
      titleSpacing: -15,
      actions:[
        const Icon(Icons.video_call, color: Colors.white,),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call, color: Colors.white,)),
        const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.more_vert),
        )],
      elevation: 2,
      backgroundColor: isDarkMode
          ? backgroundDark
          : tabColor,
      title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade400,
                      backgroundImage: NetworkImage(snapshot.data!.docs[userIndex]['image'], scale: 3,)),
                ),
            ),
            const SizedBox(width: 5,),
            InkWell(
                onTap: (){},
                child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                      alignment: Alignment.centerLeft,
                      width: w / 2.1,
                      height: h / 40,
                      child: Text(
                        snapshot.data!.docs[userIndex]['name']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      width: w / 2.1,
                      height: h / 40,
                      child: snapshot.data!.docs[userIndex]['isOnline']
                       ? const Text("Online",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,),
                      )
                       : Text(
                          DateFormat('yyyy-MM-dd').format(DateTime.now())
                              == DateFormat('yyyy-MM-dd').format(lastSeen)
                       ? "Last seen today at ${DateFormat.jm().format(lastSeen)}"
                       : "Last seen at ${DateFormat.EEEE().format(lastSeen)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.white70),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66);
}
