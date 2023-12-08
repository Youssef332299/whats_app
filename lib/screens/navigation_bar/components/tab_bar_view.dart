// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:whats_app/screens/navigation_bar/widgets/calls/calls_screen.dart';
import 'package:whats_app/screens/navigation_bar/widgets/community/communitys_screen.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/home_screen.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/story_screen.dart';

class CustomTabBarView extends StatelessWidget {
  CustomTabBarView({super.key, required this.tabController});

  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        CommunityScreen(),
        HomeScreen(),
        StoryScreen(),
        CallsScreen(),
      ],
    );
  }
}
