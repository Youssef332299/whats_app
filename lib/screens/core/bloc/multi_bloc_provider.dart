import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:whats_app/core/constant/constant.dart';
import 'package:whats_app/core/constant/statics.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/contacts/cubit/contacts_cubit.dart';
import 'package:whats_app/screens/splash/cubit/splash_cubit.dart';
import '../../navigation_bar/widgets/home/widgets/chat/cubit/chat_cubit.dart';
import '../../navigation_bar/widgets/story/cubit/story_cubit.dart';
import '../../wellcome/widgets/login/cubit/login_cubit.dart';
import '../../wellcome/widgets/register/cubit/register_cubit.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
List<SingleChildWidget> multiBlocProvider = [
  BlocProvider(create: (_) => SplashCubit()),
  BlocProvider(create: (_) => LoginCubit()),
  BlocProvider(create: (_) => RegisterCubit()),
  BlocProvider(create: (_) => StoryCubit()),
  BlocProvider(create: (_) => ContactsCubit()),
  BlocProvider(create: (_) => ChatCubit()),
];

void isOnline() {
  fireStore.collection(kUsers).doc(Statics.name).update({"isOnline": true});
  print("تم فتح التطبيق");
}

void isOffline() {
  fireStore.collection(kUsers).doc(Statics.name).update({"isOnline": false});
  fireStore.collection(kUsers).doc(Statics.name).update({"lastSeen": Timestamp.now()});
  print("تم اغلاق التطبيق");
}
