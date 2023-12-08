import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';

import '../../../../../../../core/assets/images/images.dart';

class LoadingChatWidget extends StatelessWidget {
  const LoadingChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(),
        body: Stack(
          children: [
            Image(
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
              color: Colors.white12,
              image: AssetImage(Images.doodle),
            ),
            SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 100,
                          minLines: 1,
                          cursorColor: messageColor,
                          textDirection: TextDirection.ltr,
                          // textInputAction: TextInputAction.newline,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                          decoration: InputDecoration(
                            fillColor: senderMessageColor,
                            filled: true,
                            isDense: false,
                            hintText: "Message",
                            hintTextDirection: TextDirection.ltr,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.tag_faces_rounded,
                                color: greyLight,
                              ),
                            ),
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.attach_file,
                                  color: greyLight,
                                )),
                            icon: const Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: CircleAvatar(
                                    backgroundColor: greenDark,
                                    radius: 26,
                                    child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Icon(
                                          Icons.send_outlined,
                                          color: Colors.white,
                                        )))),
                            contentPadding: const EdgeInsets.only(top: 30),
                            hintStyle: const TextStyle(
                                fontSize: 17, color: Colors.white54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  style: BorderStyle.none, width: 0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
