import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/widgets/circle_progras_indicator.dart';
import '../cubit/contacts_cubit.dart';
import 'new_add.dart';

class ContactsListView extends StatelessWidget {
  const ContactsListView({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        ContactsCubit cubit = ContactsCubit.get(context);
        return cubit.isRefresh
        ? Center(child: loading())
        : ListView.builder(
          itemCount: cubit.usersList.length,
          itemBuilder: (context, index) {
            return cubit.usersList[index].email == ""
                ? const NewAdd()
                : InkWell(
                    onTap: () => cubit.onTapUser(index, context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                NetworkImage(cubit.usersList[index].image!),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  width: w / 1.3,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    cubit.usersList[index].name!,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Container(
                                width: w / 1.3,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  cubit.usersList[index].email!,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
