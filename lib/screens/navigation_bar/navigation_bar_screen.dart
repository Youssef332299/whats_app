import 'package:flutter/material.dart';
import 'package:whats_app/screens/navigation_bar/components/app_bar.dart';
import 'package:whats_app/screens/navigation_bar/components/tab_bar_view.dart';
import 'components/floating_button.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> with TickerProviderStateMixin {
  late TabController tabController;

  void handleTabChange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, initialIndex: 1, vsync: this);
    tabController.addListener(handleTabChange);

  }

  @override
  void dispose() {
    tabController.dispose();
    tabController.removeListener(handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButton: FloatingButton(index: tabController.index),
          appBar: CustomAppBar(tapController: tabController,),
          body: CustomTabBarView(tabController: tabController,),
        ));
  }
}
