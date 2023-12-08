import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/constant/constant.dart';
import 'package:whats_app/core/widgets/circle_progras_indicator.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/components/home_list_view.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/contacts/cubit/contacts_cubit.dart';
import '../../../../core/constant/statics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference home = FirebaseFirestore.instance.
    collection(Statics.id).doc(Statics.id).collection(kHomeUser);
    return StreamBuilder<QuerySnapshot>(
        stream: home.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            context.watch<ContactsCubit>().snapshot = snapshot;
            return HomeListView(snapshot: snapshot);
          } else {
            // return const HomeLoading();
            return Center(child: loading(),);
          }
        });
  }
}
