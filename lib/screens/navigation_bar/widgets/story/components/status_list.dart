// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:status_view/status_view.dart';

// import 'package:status_view/status_view.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/components/story.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/cubit/story_cubit.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../data/model/stories_model.dart';

class StatusList extends StatelessWidget {
  StatusList({super.key, required this.cubit});

  StoryCubit cubit;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 7,
      width: width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cubit.storyList.length,
          itemBuilder: (context, index) {
            StoryModel i = cubit.storyList[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () => cubit.onTap(index, context),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: StatusView(
                        radius: 33,
                        spacing: 15,
                        strokeWidth: 2.2,
                        indexOfSeenStatus: i.seen == null
                        ? 0
                        : 1,
                        numberOfStatus: 3,
                        padding: 3.5,
                        seenColor: Colors.grey,
                        unSeenColor: tabColor,
                        centerImageUrl: "${i.userPhoto}",
                      ),
                    ),
                    Center(
                      child: Container(
                          alignment: Alignment.centerRight,
                          width: width / 5.9,
                          height: height / 30,
                          child: Text(
                            i.username!.length > 7
                                ? "${i.username!.substring(0, 6)}..."
                                : "${i.username}",
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
    );
  }
}
