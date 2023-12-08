// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import '../../../../../../../core/widgets/circle_progras_indicator.dart';
import '../cubit/contacts_cubit.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  ContactsAppBar({super.key,required this.cubit, required this.snapshot});
  ContactsCubit cubit;
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  Widget build(BuildContext context) {
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;

    return Stack(
      children: [
        AppBar(
          backgroundColor: isDarkMode ? appBarColor : messageColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 150,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Select contact",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  )),
          context.watch<ContactsCubit>().isRefresh
          ? loading()
          : Container(
                  width: 150,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${cubit.usersList.length - 1} contacts",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  )),
            ],
          ),
          leadingWidth: 30,
          actions: [
            GestureDetector(
                onTap: () => cubit.onTapSearchContact(),
                child: const Icon(Icons.search)),
            PopupMenuButton(
              color: isDarkMode ? appBarColor : Colors.white,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: const Text("Invite a friend"), onTap: () {}),
                PopupMenuItem(child: const Text("Contacts"), onTap: () {}),
                PopupMenuItem(child: const Text("Refresh"), onTap: () => context.read<ContactsCubit>().refresh(snapshot)),
                PopupMenuItem(child: const Text("New broadcast"), onTap: () {}),
                PopupMenuItem(child: const Text("Help"), onTap: () {}),
              ],
            )
          ],
        ),
        AnimatedContainer(
          curve: Curves.easeInOutCubicEmphasized,
          transformAlignment: Alignment.centerRight,
          height: cubit.search == false ? 0 : 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDarkMode ? Coloors.backgroundDark : Coloors.backgroundLight,
          ),
          onEnd: () => cubit.onAnimatedEnd(),
          duration: const Duration(milliseconds: 400),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? appBarColor : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(50)
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 15),
            child: cubit.search ? TextFormField(
              focusNode: cubit.focusNode,
              onChanged: (value) => cubit.homeSearch(value),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search email",
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                icon: IconButton(onPressed: () => cubit.onTapSearchContact(),
                  icon: const Icon(Icons.arrow_back),),

                // prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back),),
              ),
            ) : const SizedBox(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
