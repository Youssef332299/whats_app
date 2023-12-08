import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/screens/core/enum/screen_enum.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/components/loading_story.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/components/status_list.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/components/status_text.dart';
import 'package:whats_app/screens/navigation_bar/widgets/story/components/channels_page.dart';
import 'cubit/story_cubit.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    StoryCubit cubit = StoryCubit.get(context);

    return BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          if (cubit.states == ScreenStatus.done) {
            return Column(
                children: [
                  const StatusText(),
                  StatusList(cubit: cubit),
                  const ChannelsPage()
                ],
            );
          } else if (cubit.states == ScreenStatus.loading) {
            return const LoadingStory();
          } else {
            return const Center(
              child: Text("Is empty"),
            );
          }
        },
    );
  }
}
