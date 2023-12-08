import 'package:flutter/material.dart';
import 'package:status_view/status_view.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/components/channels_page.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/components/status_text.dart';

import '../../../../../core/assets/images/images.dart';

class LoadingStory extends StatelessWidget {
  const LoadingStory({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        const StatusText(),
        SizedBox(
          height: height / 7,
          width: width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: StatusView(
                            radius: 33,
                            spacing: 15,
                            strokeWidth: 2.2,
                            indexOfSeenStatus: 0,
                            numberOfStatus: 2,
                            padding: 3.5,
                            seenColor: Colors.grey,
                            unSeenColor: tabColor,
                            centerImageUrl: Images.profileImage,
                          ),
                        ),
                        Center(
                          child: Container(
                              alignment: Alignment.centerRight,
                              width: width / 5.9,
                              height: height / 30,
                              child: Text(
                                  "User...",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.grey.shade800),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        const ChannelsPage()
      ],
    );
  }
}
