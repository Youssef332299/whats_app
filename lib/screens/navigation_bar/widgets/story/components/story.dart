// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import '../../../../../core/assets/images/images.dart';
import '../../../../../data/model/stories_model.dart';
import 'package:intl/intl.dart';

class Story extends StatelessWidget {
  Story({super.key, required this.index, required this.storyList});

  int index;

  List<StoryModel> storyList;
  PageController? pageController;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    pageController = PageController(initialPage: index);
    return Scaffold(
        body: GestureDetector(
      onVerticalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          Navigator.of(context).pop();
        } else if (details.primaryVelocity! < 0) {
          showBottomSheet(context);
        }
      },
      child: Center(
        child: PageView.builder(
          controller: pageController,
          itemCount: storyList.length,
          itemBuilder: (BuildContext context, int index) {
            final storyData = storyList[index];
            // item.clear();
            for (var element in storyData.userStory!) {
              if (element.type == Type.TEXT) {
                // item.add(StoryItem.text(
                //     title: element.body!, backgroundColor: Colors.black));
              }
              if (element.type == Type.IMAGE) {
                // item.add(StoryItem.pageImage(
                //     url: element.body!, controller: storyController));
              }
            }
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.black,
                    child: Image.network(storyData.userStory![0].body!,
                        fit: BoxFit.fitWidth),
                  ),
                ),
                // Center(
                //     child: Text(
                //   storyData.userStory![1].body!,
                // )),

                Positioned(
                    top: 30,
                    child: LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      width: width,
                      barRadius: const Radius.circular(8),
                      lineHeight: 2,
                      percent: 1,
                      backgroundColor: Colors.white54,
                      progressColor: Colors.white,
                      animateFromLastPercent: true,
                      animation: true,
                      animationDuration: 6000,
                      onAnimationEnd: () {
                        pageController?.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn);
                        storyList.removeAt(index);
                      },
                    )),
                Positioned(
                    top: 45,
                    left: 5,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop,
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 45,
                    left: 50,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(storyData.userPhoto!),
                        radius: 23,
                      ),
                    )),
                Positioned(
                  left: 110,
                  top: 48,
                  child: Text(
                    storyData.username.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
                Positioned(
                  left: 110,
                  top: 73,
                  child: Text(
                    "${DateFormat.EEEE().format(storyData.storyTime!)} ${DateFormat.jm().format(storyData.storyTime!)}",
                    style: const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        context: context,
        builder: (BuildContext context) {
          double h = MediaQuery.of(context).size.height;
          double w = MediaQuery.of(context).size.width;
          return SizedBox(
              height: h / 5,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: tabColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    width: w,
                    height: h / 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Viewed by 0",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            Images.facebook,
                            scale: 22,
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.more_vert))
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
