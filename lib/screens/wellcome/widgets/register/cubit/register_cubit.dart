import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_app/core/constant/constant.dart';
import 'package:whats_app/core/constant/statics.dart';
import 'package:whats_app/data/model/user_data_model.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial()) {
    focusBoolean();
  }

  static RegisterCubit get(context) => BlocProvider.of(context);

  UploadTask? uploadTask;
  File? selectedImage;

  String imageName = '';
  bool isLoading = false;
  bool emojiShowing = false;
  FocusNode focusNode = FocusNode();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();


  Future<void> registerUser(String email, String pass) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      Statics.id = email;
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterError(errorMessage: e.code));
    }
  }

  Future<void> saveUserDataToFireStore(String imageUrl) async {
    CollectionReference users = FirebaseFirestore.instance.collection(kUsers);
    UserDataModel userData = UserDataModel(
      name: name.text,
      image: imageUrl,
      userAppToken: Statics.appToken,
      email: Statics.id,
      createdAt: DateTime.now(),
      status: 'status',
      lastSeen: DateTime.now(),
      isOnline: true,
    );
    await users.doc(name.text).set(userData.toJson());
  }

  Future<String> uploadImageToFirebaseStorage() async {
    Reference ref = FirebaseStorage.instance.ref().child(imageName);
    uploadTask = ref.putFile(File(selectedImage!.path));
    final snapshot = await uploadTask!.whenComplete(() => null);
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> onTapNextButton() async {
    emit(RegisterLoading());
    try {
      String imageUrl = await uploadImageToFirebaseStorage();
      await saveUserDataToFireStore(imageUrl);
      Statics.name = name.text;
      Statics.id = email.text;
      Statics.profileImage = imageUrl;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool(kNewClient, false);
      await sharedPreferences.setString(kEmail, email.text);
      await sharedPreferences.setString(kPass, pass.text);
      await sharedPreferences.setString(kUsername, name.text);
      await sharedPreferences.setString(kProfileImage, imageUrl);
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterError(errorMessage: "An error occurred"));
    }
  }

  void removeProfileImage(context) {
    selectedImage = null;
    Navigator.of(context).pop();
    emit(ImageSelected());
  }

  Future getImageFromGallery(context) async {
    Navigator.of(context).pop();
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    image != null ? selectedImage = File(image.path) : null;
    imageName = image!.name;
    emit(ImageSelected());
  }

  Future getImageFromCamera(context) async {
    Navigator.of(context).pop();
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    image == null ? null : selectedImage = File(image.path);
    imageName = image!.path;
    emit(ImageSelected());
  }

  void onTapEmojiIcon() {
    focusNode.hasFocus ? focusNode.unfocus() : null;
    emojiShowing = !emojiShowing;
    emit(RegisterEmoji());
  }

  void onTapTextField() {
    focusNode.hasFocus ? focusNode.unfocus() : null;
    emojiShowing = false;
    emit(RegisterEmoji());
  }

  void focusBoolean() {
    focusNode.addListener(() {
      emit(RegisterFocus());
    });
  }

  void addEmojiToTextController({required Emoji emoji}) {
    name.text = name.text + emoji.emoji;
    name.selection =
        TextSelection.fromPosition(TextPosition(offset: name.text.length));
  }


}
