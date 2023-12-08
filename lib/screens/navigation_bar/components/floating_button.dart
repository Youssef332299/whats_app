import 'package:flutter/material.dart';
import '../../../core/route/route_navigation_slide.dart';
import '../widgets/home/widgets/contacts/contacts_screen.dart';
import '../widgets/story/components/floating_action_button.dart';
import 'custom_button.dart';

// ignore: must_be_immutable
class FloatingButton extends StatelessWidget {
  FloatingButton({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
      switch (index){
        case 1:
          return CustomButton(icon: Icons.message, onTap: (){
            Navigator.of(context).push(buildRoute(const ContactsScreen()));
          },);
        case 2:
          return CustomFloatingActionButton(index: index, onTapCamera: (){}, onTapPen: (){},);
        case 3:
          return CustomButton(icon: Icons.add_call, onTap: (){},);
        default:
          return const SizedBox();
    }
  }
}
