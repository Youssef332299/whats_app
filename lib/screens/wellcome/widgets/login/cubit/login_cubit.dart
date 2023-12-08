import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;
  bool? isWhatsAppUser;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<void> loginUser(String email, String pass) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginError(errorMessage: e.code));
    }
  }
}
