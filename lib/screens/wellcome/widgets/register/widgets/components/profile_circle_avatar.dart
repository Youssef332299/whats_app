import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import '../../cubit/register_cubit.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    RegisterCubit cubit = RegisterCubit.get(context);
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: Text(
                "Please provide your name and an optional profile photo",
                style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
            SizedBox(
              height: height / 35,
            ),
            Center(
              child: GestureDetector(
                  onTap: () => showBottomSheet(cubit, context),
                  child: cubit.selectedImage == null
                      ? CircleAvatar(
                          radius: 54,
                          backgroundColor: const Color(0xBBE3EEEF),
                          child: Icon(
                            Icons.add_a_photo,
                            color: isDarkMode
                                ? Colors.black38
                                : const Color(0xB5B5BDBE),
                            size: 44,
                          ),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black26,
                          backgroundImage: FileImage(cubit.selectedImage!),
                        )),
            ),
          ],
        );
      },
    );
  }

  showBottomSheet(cubit, context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final Brightness platformBrightness =
            MediaQuery.of(context).platformBrightness;
        final bool isDarkMode = platformBrightness == Brightness.dark;
        return SizedBox(
          height: 190,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Divider(
                thickness: 3.2,
                color: Colors.black54,
                indent: 170,
                endIndent: 170,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "     Profile photo",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                  ),
                  cubit.selectedImage == null
                      ? const SizedBox(
                          width: 5,
                        )
                      : IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (context) => Platform.isIOS
                                    ? CupertinoAlertDialog(
                                        title: Text(
                                          "Remove profile photo?",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: isDarkMode
                                                  ? Colors.white60
                                                  : Colors.black45),                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: messageColor),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                cubit.removeProfileImage(
                                                    context);
                                              },
                                              child: const Text(
                                                "Remove",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: messageColor),
                                              )),
                                        ],
                                      )
                                    : AlertDialog(
                                        elevation: 0,
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                                color: Colors.black12,
                                                width: .0)),
                                        title: Text(
                                          "Remove profile photo? ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: isDarkMode
                                                  ? Colors.white60
                                                  : Colors.black45)),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "Cancel  ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: messageColor),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                cubit.removeProfileImage(
                                                    context);
                                              },
                                              child: const Text(
                                                "Remove  ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: messageColor),
                                              )),
                                        ],
                                      ));
                          },
                          icon: const Icon(Icons.more_vert)),
                ],
              ),
              SizedBox(
                // height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      child: IconButton(
                          onPressed: () {
                            cubit.getImageFromCamera(context);
                          },
                          icon: const Icon(Icons.camera_alt_rounded,
                              color: messageColor)),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: IconButton(
                          onPressed: () {
                            cubit.getImageFromGallery(context);
                          },
                          icon: const Icon(Icons.insert_photo,
                              color: messageColor)),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.profile_circle,
                              color: messageColor)),
                    ),
                    const SizedBox(
                      width: 90,
                    )
                  ],
                ),
              ),
              Row(children: [
                const SizedBox(
                  width: 28,
                ),
                Text(
                  "Camera",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: isDarkMode ? Colors.white60 : Colors.black45),
                ),
                const SizedBox(
                  width: 35,
                ),
                Text(
                  "Gallery",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: isDarkMode ? Colors.white60 : Colors.black45),
                ),
                const SizedBox(
                  width: 45,
                ),
                Text(
                  "Avatar",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: isDarkMode ? Colors.white60 : Colors.black45),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
