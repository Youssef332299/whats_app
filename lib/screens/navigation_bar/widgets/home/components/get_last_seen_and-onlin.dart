import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/core/constant/constant.dart';
import 'package:whats_app/core/constant/statics.dart';

// ignore: must_be_immutable
class GetOnlineAndLastSeen extends StatelessWidget {
  GetOnlineAndLastSeen({super.key, required this.email});
  String email;
  CollectionReference users = FirebaseFirestore.instance.collection(kUsers);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (context, snapshot) {
        print("done");
        for(int i = 0; i < snapshot.data!.docs.length; i++){
        print("done and is in for loop");
          if(snapshot.data!.docs[i]['email'] == email){
        print("done and is in if condition");
            // print("email: ${snapshot.data!.docs[i]['email']} =================================* ============");
            Timestamp lastSeenTime = snapshot.data!.docs[i]['lastSeen'] as Timestamp;
            DateTime lastSeen = lastSeenTime.toDate();
            Statics.lastSeen = lastSeen;
            Statics.isOnline = snapshot.data!.docs[i]['lastSeen'];
            // print("Statics.isOnline: ${Statics.isOnline} =================================* ============");
          }
        }
        return const SizedBox();
        },
    );
  }
}
