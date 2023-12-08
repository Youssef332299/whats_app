import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(CommunityInitial());
}
