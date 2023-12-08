import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../data/model/stories_model.dart';

// ignore: must_be_immutable
class StoryItem extends StatelessWidget {
  StoryItem({super.key, required this.item, required this.onClick});
  StoryModel item;
  Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        margin: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 70,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 70,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(item.userPhoto!),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                height: 100,
                width: 200,
                alignment: Alignment.topLeft,
                child: Column(children: [
                  Text(
                    item.username!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
              Container(
                height: 100,
                width: 60,
                alignment: Alignment.topRight,
                child: Column(children: [
                  Text(
                    timeago.format(item.storyTime!),
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
