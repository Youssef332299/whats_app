import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/constant/constant.dart';
import '../../../../../../../core/constant/statics.dart';
import '../../../../../../../core/route/route_navigation_slide.dart';
import '../../../../../../../data/model/user_data_model.dart';
import '../../../../../../core/bloc/multi_bloc_provider.dart';
import '../../chat/chat_screen.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());

  static ContactsCubit get(context) => BlocProvider.of(context);

  bool search = false;
  bool isRefresh = false;
  String documentId = '';
  AsyncSnapshot<QuerySnapshot<Object?>>? snapshot;

  FocusNode focusNode = FocusNode();
  List<UserDataModel> usersList = [];

  static List<UserDataModel> users = [
    UserDataModel(
      name: "",
      image: "",
      userAppToken: "",
      email: "",
      createdAt: DateTime.timestamp().add(const Duration(days: 3, hours: 2)),
      status: '',
      lastSeen: DateTime.timestamp().add(const Duration(days: 3, hours: 2)),
      isOnline: true,
    )
  ];

  Future<void> refresh(snapshot) async {
    isRefresh = true;
    emit(ContactFillData());
    await Future.delayed(const Duration(milliseconds: 400));
    users.clear();
    usersList.clear();
    users.add(UserDataModel(
      name: "",
      image: "",
      userAppToken: "",
      email: "",
      createdAt: DateTime.timestamp().add(const Duration(days: 3, hours: 2)),
      status: '',
      lastSeen: DateTime.timestamp().add(const Duration(days: 3, hours: 2)),
      isOnline: true,
    ));
    fillUserList(snapshot);
  }

  void fillUserList(snapshot) {
    if (users.length == 1) {
      for (int i = 0; i < snapshot.data!.docs.length; i++) {
        DocumentSnapshot doc = snapshot.data!.docs[i];
        if (doc.data() != null && doc['email'] != Statics.id) {
          Timestamp lastSeenTime = doc["lastSeen"] as Timestamp;
          DateTime lastSeen = lastSeenTime.toDate();
          Timestamp createdAtTime = doc["createdAt"] as Timestamp;
          DateTime createdAt = createdAtTime.toDate();
          users.add(UserDataModel(
            name: doc["name"],
            image: doc["image"],
            userAppToken: doc["userAppToken"],
            email: doc["email"],
            createdAt: createdAt,
            status: doc['status'],
            lastSeen: lastSeen,
            isOnline: doc["isOnline"],
          ));
        }
      }
      usersList = List.from(users);
      isRefresh ? isRefresh = false : null;
      emit(ContactFillData());
    }
  }

  void homeSearch(String value) {
    usersList = users
        .where((element) => element.email!.toLowerCase().contains(value))
        .toList();
    emit(ContactSearch());
  }

  void onTapSearchContact() {
    search = !search;
    emit(ContactSearch());
  }

  void onAnimatedEnd() {
    focusNode.hasFocus ? focusNode.unfocus() : focusNode.requestFocus();
    emit(ContactSearch());
  }

  Future<void> onTapUser(index, context) async {
    Statics.consigneeToken = usersList[index].userAppToken!;
    bool isContain = false;
    CollectionReference home =
    FirebaseFirestore.instance.collection(Statics.id).doc(Statics.id).collection(kHomeUser);
    for(int i = 0; i < snapshot!.data!.docs.length; i++){
      snapshot!.data!.docs[i]['email'] == usersList[index].email ? isContain = true : null;
    }

    if (!isContain) {
      DocumentReference addedDocRef = await home.add({
        "name": usersList[index].name,
        "image": usersList[index].image,
        "userAppToken": usersList[index].userAppToken,
        "email": usersList[index].email,
        "createdAt": usersList[index].createdAt,
        "status": usersList[index].status,
        "lastSeen": usersList[index].lastSeen,
        "isOnline": usersList[index].isOnline,
        "lastMessage": "",
        "documentId": "",
        "haveNewMessage": false,
        "isInChat": false,
      });
      documentId = addedDocRef.id;
      fireStore.collection(Statics.id).doc(Statics.id).
      collection(kHomeUser).doc(documentId).update({"documentId": addedDocRef.id});
    }
    Navigator.of(context).pushReplacement(buildRoute(ChatScreen(
      data: UserDataModel(
        name: usersList[index].name,
        image: usersList[index].image,
        userAppToken: usersList[index].userAppToken,
        email: usersList[index].email,
        createdAt: usersList[index].createdAt,
        status: usersList[index].status,
        lastSeen: usersList[index].lastSeen,
        isOnline: usersList[index].isOnline,
      ), documentId: documentId,
         isInChat: true,
      ),
    ));
  }
}
