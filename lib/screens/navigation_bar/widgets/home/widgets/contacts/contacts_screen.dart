import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/constant/constant.dart';
import 'package:whats_app/core/widgets/circle_progras_indicator.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/contacts/components/contacts_app_bar.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/contacts/components/contacts_list_view.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/contacts/cubit/contacts_cubit.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(kUsers);
    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy("name").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BlocBuilder<ContactsCubit, ContactsState>(
            builder: (context, state) {
              ContactsCubit cubit = ContactsCubit.get(context);
              cubit.fillUserList(snapshot);
              return Scaffold(
                appBar: ContactsAppBar(cubit: cubit, snapshot: snapshot),
                body: const ContactsListView(),
              );
            },
          );
        } else {
          return Scaffold(body: Center(child: loading()));
        }
      },
    );
  }
}
