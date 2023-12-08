import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/screens/core/enum/screen_enum.dart';
import '../../../../../data/model/stories_model.dart';
import '../../../../../data/services/stories_services.dart';
import '../components/story.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial()) {
    initState();
  }

  static StoryCubit get(context) => BlocProvider.of(context);

  ScreenStatus states = ScreenStatus.init;
  List<StoryModel> storyList = [];

  Future initState() async {
    states = ScreenStatus.loading;
    storyList = await StoryServices().getStoryList();
    states = ScreenStatus.done;
    emit(StoryInitial());
  }

  void onTap(index, context) {
    var i = storyList[index];
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Story(
              index: index,
              storyList: storyList,
            ))); // o.addToSeen(index);
    storyList.add(StoryModel(
        seen: true,
        username: i.username,
        storyTime: i.storyTime,
        userId: i.userId,
        userPhoto: i.userPhoto,
        userStory: i.userStory));
    emit(AddToSeen());
  }
}
