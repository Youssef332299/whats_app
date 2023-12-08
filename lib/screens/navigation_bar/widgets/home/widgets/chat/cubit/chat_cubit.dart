import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app/screens/navigation_bar/widgets/home/widgets/chat/components/chat_send_data.dart';
import '../../../../../../../core/constant/constant.dart';
import '../../../../../../../core/constant/statics.dart';
import '../../../../../../core/bloc/multi_bloc_provider.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  int messageIndex = 0;

  bool send = false;
  bool isInChat = false;
  bool repMessage = false;
  bool isSendFile = false;
  bool imageScreen = false;
  bool emojiShowing = false;
  bool animatedRepContainerEnd = false;

  String imageName = '';
  String message = '';
  String textRep = '';
  String messageId = '';
  String documentId = '';
  String emailRepMessage = '';

  File? selectedImage;
  UploadTask? uploadTask;
  String messageRep = '';

  FocusNode focusNode = FocusNode();
  AsyncSnapshot<QuerySnapshot<Object?>>? snapshot;
  ScrollController controller = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  void addEmojiToTextController({required Emoji emoji}) {
    send = true;
    textEditingController.text += emoji.emoji;
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
    emit(ChatOnChanged());
  }

  void focusBoolean() {
    focusNode.addListener(() {
      emit(ChatFocus());
    });
  }

  void onTapTextField() {
    if (isSendFile) {
      focusNode.unfocus();
      isSendFile = false;
    } else {
      !focusNode.hasFocus ? focusNode.requestFocus() : null;
      emojiShowing = false;
    }
    emit(ChatTapText());
  }

  void onChanged() {
    if (textEditingController.text.isNotEmpty) {
      send = true;
    } else {
      send = false;
    }
    emit(ChatOnChanged());
  }

  void onTapEmojiIcon() {
    if (isSendFile) {
      isSendFile = false;
    } else {
      emojiShowing = !emojiShowing;
      focusNode.hasFocus ? focusNode.unfocus() : null;
      isSendFile = false;
    }
    emit(ChatEmojiIcon());
  }

  void sendFile() {
    isSendFile = !isSendFile;
    emit(ChatSendFile());
  }

  Future<void> onSend(String documentUserId, id, context) async {
    List<String> ids = [Statics.id, id];
    ids.sort();
    String chatRoomId = ids.join('_');

    imageScreen ? Navigator.of(context).pop() : null;

    if (textEditingController.text.isNotEmpty || message != '') {
      Statics.sendNotification(textEditingController.text, message);
      Map<String, dynamic> messageSend = {
        "date": DateTime.now(),
        "id": Statics.id,
        "token": Statics.appToken,
        "state": kSenderHaveNoInternet,
        "text": textEditingController.text,
        "file": message,
        "repText": textRep,
        "repMessage": messageRep,
        "repFromMe": messageId == Statics.id ? true : false,
      };
      fireStore
          .collection(kWhatsAppChats)
          .doc(chatRoomId)
          .collection(kChat)
          .add(messageSend);
      fireStore
          .collection(Statics.id)
          .doc(Statics.id)
          .collection(kHomeUser)
          .doc(documentUserId)
          .update({"lastMessage": textEditingController.text});
      String randomId = "${Random().nextInt(5000000)}asd";
      documentId == ""
          ? fireStore
              .collection(id)
              .doc(id)
              .collection(kHomeUser)
              .doc(randomId)
              .set({
              "lastMessage": textEditingController.text,
              "name": Statics.name,
              "email": Statics.id,
              "image": Statics.profileImage,
              "isOnline": true,
              "status": "status",
              "userAppToken": Statics.appToken,
              "lastSeen": DateTime.now(),
              "createdAt": DateTime.now(),
              'documentId': randomId,
              "haveNewMessage": isInChat ? false : true,
            })
          : fireStore
              .collection(id)
              .doc(id)
              .collection(kHomeUser)
              .doc(documentId)
              .update({
              'lastMessage': textEditingController.text,
              "haveNewMessage": true,
            });
      Statics.checkDataSentSuccessfully(true);
      // checkInternet(chatRoomId);
      textEditingController.clear();
      onTapCancelRep();
      emit(ChatOnSend());
      controller.animateTo(0,
          duration: const Duration(microseconds: 220), curve: Curves.linear);
    }
  }

  String getChatRoomId(String id) {
    List<String> ids = [Statics.id, id];
    ids.sort();
    String chatRoomId = ids.join('_');
    return chatRoomId;
  }

  Stream<QuerySnapshot> getMessages(id) {
    return fireStore
        .collection(kWhatsAppChats)
        .doc(getChatRoomId(id))
        .collection(kChat)
        .orderBy(kTime, descending: true)
        .snapshots();
  }

  Future<void> onSwipeMessage(
      String message, String messageID, RepIndex, repFile) async {
    animatedRepContainerEnd = true;
    messageIndex = RepIndex;
    messageId = messageID;
    messageRep = repFile;
    print(messageRep);
    print("==========================================");
    // repMessage = RepMessage;
    focusNode.requestFocus();
    if (repMessage == false) {
      repMessage = true;
      await Future.delayed(
        const Duration(milliseconds: 100),
        () {
          animatedRepContainerEnd = false;
        },
      );
    } else {}
    textRep = message;
    emit(ChatRepMessage());
  }

  void onTapCancelRep() {
    animatedRepContainerEnd = false;
    repMessage = false;
    send = false;
    imageScreen = false;
    messageRep = '';
    textRep = '';
    message = '';
    emit(ChatRepMessage());
  }

  void onAnimatedEnd() {
    animatedRepContainerEnd = true;
    emit(ChatRepMessage());
  }

  void endChat() {
    textEditingController.clear();
    repMessage = false;
    focusNode.unfocus();
    documentId = '';
    animatedRepContainerEnd = false;
    isSendFile = false;
    Statics.chatName = '';
    emit(ChatOnChanged());
  }

  void getDocumentId(lastMessageSnapshot) {
    if (documentId == "") {
      for (int i = 0; i < lastMessageSnapshot.data!.docs.length; i++) {
        if (lastMessageSnapshot.data!.docs[i]['email'] == Statics.id) {
          documentId = lastMessageSnapshot.data!.docs[i]['documentId'];
          print("getDocumentId\ndocumentId: $documentId");
        }
      }
    }
  }

  Future<void> getImageFromGallery(docID, id, context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatSendData(
          selectedImage: selectedImage!,
          docID: docID,
          id: id,
        ),
      ));
      imageName = image.name;
      uploadImageToFirebaseStorage(docID, id, context);
    }
    emit(ChatSendFile());
  }

  Future<void> uploadImageToFirebaseStorage(docID, id, context) async {
    Reference ref = FirebaseStorage.instance.ref().child(imageName);
    uploadTask = ref.putFile(File(selectedImage!.path));
    final snapshot = await uploadTask!.whenComplete(() => null);
    final downloadURL = await snapshot.ref.getDownloadURL();
    message = downloadURL;
    print(message);
    emit(ChatOnSend());
  }

  Widget seenMessageIcon(state) {
    switch (state) {
      case kSeen:
        emit(ChatOnSend());
        return const Stack(
          children: [
            Icon(
              Icons.check,
              size: 16,
              color: Colors.blue,
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.5),
              child: Icon(
                Icons.check,
                size: 16,
                color: Colors.blue,
              ),
            )
          ],
        );
      case kReviseUnread:
        emit(ChatOnSend());
        return const Stack(
          children: [
            Icon(
              Icons.check,
              size: 16,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.5),
              child: Icon(
                Icons.check,
                size: 16,
                color: Colors.grey,
              ),
            )
          ],
        );
      case kReviseHaveNoInternet:
        emit(ChatOnSend());
        return const Icon(
          Icons.check,
          color: Colors.grey,
          size: 16,
        );
      default:
        emit(ChatOnSend());
        return const Icon(Icons.access_time, color: Colors.grey, size: 16);
    }
  }

  checkInternet(chatRoomId, documentId) async {
    try {
      // to check internet
      var result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        fireStore
            .collection(kWhatsAppChats)
            .doc(chatRoomId)
            .collection(kChat)
            .doc(documentId)
            .update({"state": kReviseHaveNoInternet});
        print('have net');
      }
    } on SocketException catch (_) {
      // If user have no internet
      print('No net');
    }
  }
}
