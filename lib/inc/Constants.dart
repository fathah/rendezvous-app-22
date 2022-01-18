import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
export 'package:get/get.dart';
export 'strings.dart';

class Constants {
  static const DUMMY = "";
}

Box? mainBox;
Box? programBox;
Box? numKeyBox;
Box? vrBox;

const MAIN_ORANGE = Color(0xFFC14332);
const MAIN_GREEN = Color(0xFF62948B);

const ROOT_URL = "https://manzilmedia.net/apps/rendezvous/api";
const API_KEY = "113ce5901af9a9fdde303c55de9dfd06";

snackBar({title, body, color}) {
  Get.snackbar(title, body,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 0,
      margin: EdgeInsets.all(0),
      backgroundColor: color ?? MAIN_GREEN,
      colorText: Colors.white);
}
