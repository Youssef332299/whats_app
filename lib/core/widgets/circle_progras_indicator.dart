import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';
import 'dart:io' show Platform;

Widget loading() {
  if (Platform.isIOS) {
    return const CupertinoActivityIndicator(
      radius: 20.0,
      color: messageColor,
    );
  } else {
    return const CircularProgressIndicator(
      color: messageColor,
    );
  }
}

