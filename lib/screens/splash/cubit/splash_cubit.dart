import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constant/constant.dart';
import '../../../core/constant/statics.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()){
    handleData();
  }

  static SplashCubit get(context)=> BlocProvider.of(context);

  bool newClient = true;

  Future<void> getNewClient() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? clientBoolSaved = sharedPreferences.getBool(kNewClient);
    Statics.newClient = clientBoolSaved == false ? false : true;
    if (Statics.newClient == false) {
      Statics.id = sharedPreferences.getString(kEmail) ?? "";
      Statics.name = sharedPreferences.getString(kUsername) ?? "";
      Statics.pass = sharedPreferences.getString(kPass) ?? "";
      Statics.profileImage = sharedPreferences.getString(kProfileImage) ?? "";
      newClient = false;
    }
  }

  loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: Statics.id, password: Statics.pass);
      Statics().getToken();
      newClient = false;
    } on FirebaseAuthException catch (e) {
      newClient = true;
    }
  }

  Future<void> handleData() async {
    await getNewClient();
    await loginUser();
    await Future.delayed(const Duration(milliseconds: 100));
    emit(SplashEnd());
  }
  void internetState() async{
    bool state = await Statics.checkInternet();
    state ? emit(SplashEndAndConnected()) : emit(SplashEndButNoNetwork());
  }

}
