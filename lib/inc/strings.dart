import 'package:flutter/material.dart';

const mainColor = Color(0xFFC14332);
const mainColorAccent = Color(0xff77AB58);
const blue = Color(0xff246CD0);
//const mainColor = Color(0xff08448A);
const rateStar = mainColor; //Color(0xffFFC14D);
var rateGrey = Colors.black38;
var backLightGrey = Color(0xfff5f6fa);
var skeltonLoadBG = Color(0xffE3E3E3);

String mainFont = "Montserrat";
String merri = "Merriweather";
String roboto = "Roboto";
String sakkal = "Sakkal";
String arabic = "Arabic";

String key = "29ac983eb5e7385be5d1d0b538d569b1";
String ziqx = "88572a636fec095b2be3cdde678c2097";

var teamRed = Color(0xffc0392b);
var teamGreen = Color(0xff27ae60);
var teamBlue = Color(0xff2980b9);

const MaterialColor primaryColor = MaterialColor(
  _primaryColorVal,
  <int, Color>{
    50: Color(0xFF8e44ad),
    100: Color(0xffdcdde1),
    200: Color(0xff74b9ff),
    300: Color(_primaryColorVal),
    400: Color(0xFF2ecc71),
    500: Color(_primaryColorVal),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _primaryColorVal = 0xFFC14332;

br(double height) {
  return SizedBox(
    height: height,
  );
}

brw(double width) {
  return SizedBox(
    width: width,
  );
}

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }
