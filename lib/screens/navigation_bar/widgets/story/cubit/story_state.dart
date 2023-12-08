part of 'story_cubit.dart';

abstract class StoryState {}

class StoryInitial extends StoryState {
  ScreenStatus status = ScreenStatus.done;
}
class AddToSeen extends StoryState {}
