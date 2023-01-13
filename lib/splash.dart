import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rendezvous/View/Participant/Index.dart';
import 'package:rendezvous/api/get_teams.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/models/db.dart';

import 'Functions/getAPIData.dart';
import 'View/Home/Home.dart';
import 'inc/common.dart';
import 'inc/transition.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? team = getTeam();
  Directory? dir;
  File? stdFile;
  File? jsonFile;

  @override
  void initState() {
    super.initState();
    
    Timer(Duration(milliseconds: 3000), () {
      if (mainBox!.get(DBKeys.userId) != null && mainBox!.get(DBKeys.cardNo) != null) {
        Navigator.of(context)
            .pushReplacement(FadeRoute(page: ParticipantHomeIndex()));
      } else {
        Navigator.of(context).pushReplacement(FadeRoute(page: Home()));
      }
    });
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      stdFile = File(dir!.path + "/" + "students.json");

      setState(() {
        dir = directory;
        stdFile = File(dir!.path + "/" + "students.json");
        jsonFile = File(dir!.path + "/" + "teamScore.json");
      });

      await saveJSON(stdFile!, 'students').then((value) async {
        await saveToDB('teamScore');
        Timer(Duration(milliseconds: 2000), () {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: getThemeColor(team),
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ColorizeAnimatedTextKit(
                      text: ["Rendezvous"],
                      textStyle: TextStyle(
                          fontSize: 45.0,
                          fontFamily: mainFont,
                          color: Colors.white),
                      textAlign: TextAlign.start,
                      colors: [Colors.white, Colors.white38, Colors.white24],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        br(10),
                        Text(
                          "Manzil Developers",
                          style: TextStyle(color: Colors.white),
                        ),
                        br(20)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
