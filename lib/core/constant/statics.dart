import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats_app/core/constant/constant.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../screens/core/bloc/multi_bloc_provider.dart';
import '../assets/sounds/sounds.dart';

class Statics {
  static String id = '';
  static String pass = '';
  static String name = '';
  static String chatId = '';
  static String chatName = '';
  static String appToken = '';
  static String lastMessage = '';
  static String profileImage = '';
  static String consigneeToken = '';
  static String state = '';

  static bool? isOnline;
  static bool? newClient;
  static DateTime? lastSeen;
  static List<Map<String, dynamic>> homeNotification = [];
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void initNotification() async {
    await firebaseMessaging.requestPermission();
    getToken();
  }

  static String getLastMessage(snapshot, index) {
    String? lastMessage = snapshot.data!.docs[index]["text"];
    return lastMessage!;
  }

  static String getLastMessageDate(snapshot, index) {
    Timestamp timestamp = snapshot.data!.docs[index][kTime] as Timestamp;
    DateTime dateTime = timestamp.toDate();
    String? lastMessageDate = DateFormat.EEEE().format(dateTime).toString();
    return lastMessageDate;
  }

  static sendNotification(String message, image) async {
       // String chatRoomId, String documentId

    if (consigneeToken != "") {
      var headersList = {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': kAppKeyServer
      };
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var body = image != ''
      ? {
        "to": consigneeToken,
        "notification": {
          "title": name,
          "body": message,
          "mutable_content": true,
          "sound": "Tri-tone",
          "image": image,
          // 'data': {
          //   'chatRoomId': chatRoomId,
          //   'documentId': documentId,
          // },
        }
      }
      : {
        "to": consigneeToken,
        "notification": {
          "title": name,
          "body": message,
          "mutable_content": true,
          "sound": "Tri-tone",

          // 'data': {
          //   'chatRoomId': chatRoomId,
          //   'documentId': documentId,
          // },
        }
      };
      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);
      var res = await req.send();
      if (res.statusCode >= 200 && res.statusCode < 300) {}
    }
  }

  void getToken() async {
    final token = await firebaseMessaging.getToken();
    appToken = token!;
  }

  static void checkDataSentSuccessfully(bool fromMe) {
    if (fromMe) {
      final player = AudioPlayer();
      player.play(AssetSource(Sounds.sendMessage));
    } else {
      final player = AudioPlayer();
      player.play(AssetSource(Sounds.receiveMessage));
    }
  }

  static void whenUserHaveMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null && chatName == message.notification!.title) {
        checkDataSentSuccessfully(false);
        String chatRoomId = message.data['chatRoomId'];
        String documentId = message.data['documentId'];
        fireStore.collection(kWhatsAppChats).doc(chatRoomId).
        collection(kChat).doc(documentId).update({"state": kReviseUnread});
        print('chat name: $chatName');
        print('message data : ${message.data}');
        print("================================================================");
      }
    });
  }

  static checkInternet() async {
    try {
      // to check internet
      var result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      // If user have no internet
      return false;
    }
  }
}
