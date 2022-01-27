import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rendezvous/Functions/login.dart';
import 'package:rendezvous/View/Home/Home.dart';
import 'package:rendezvous/inc/Constants.dart';

import 'strings.dart';

bool isLogged() {
  if (mainBox!.get('userId') != null && mainBox!.get('cardId') != null) {
    return true;
  } else {
    return false;
  }
}

saveChest(chest) {
  mainBox!.put('chestId', chest);
}

Future<String?> getChest() {
  return mainBox!.get('chestId');
}

//Team
saveTeam(team) {
  mainBox!.put('team', team);
}

String getTeam() {
  return mainBox!.get('team') ?? "null";
}

logout(context) async {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              br(35),
              Text("Are you Sure! Do you want to log out?"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Stay",
                      style: TextStyle(color: mainColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  OutlineButton(
                    highlightedBorderColor: Colors.red,
                    onPressed: () async {
                      await logoutUser().then((value) {
                        mainBox!.clear();
                        vrBox!.clear();
                        Get.offAll(Home());
                      });
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
              br(35),
            ],
          ),
        );
      });
}

Color getThemeColor(team) {
  switch (team) {
    case 'nn':
      return teamBlue;

    case 'be':
      return teamRed;

    case 'is':
      return teamGreen;

    default:
      return mainColor;
  }
}

Future<File> imageFromAsset(String path) async {
  var bytes = await rootBundle.load('assets/$path');
  String tempPath = (await getTemporaryDirectory()).path;
  File file = File('$tempPath/$path');
  await file.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

  return file;
}

Future downloadCertificate() async {
  String url = "https://markazgarden.org/rendezvous";
  var res = await http.get(Uri.parse(url + "/certificate.jpg"));

  await getApplicationDocumentsDirectory().then((dir) async {
    File file = File(dir.path + "/certificate.jpg");
    if (!file.existsSync()) {
      file.writeAsBytesSync(res.bodyBytes);
    }
  });
  return true;
}

String getSection(sec) {
  switch (sec) {
    case 'pr':
      return "Primary";

    case 'sc':
      return "Secondary";

    case 'sj':
      return "Sub Junior";

    case 'jr':
      return "Junior";

    case 'sn':
      return "Senior";

    case 'gn':
      return "General";

    default:
      return "Unknown";
  }
}

Color getNotifColor(type) {
  switch (type) {
    case "Alert":
      return Color(0xff3498db);
    case "Notice":
      return Color(0xff8e44ad);
    case "Warning":
      return Color(0xffe74c3c);
    default:
      return Color(0xfff39c12);
  }
}

IconData getNotifIcon(type) {
  switch (type) {
    case "Alert":
      return Icons.info_outline_rounded;
    case "Notice":
      return Icons.event_note_rounded;
    case "Warning":
      return Icons.warning_amber;
    default:
      return Icons.notifications_none;
  }
}
