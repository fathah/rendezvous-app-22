import 'package:flutter/material.dart';
import 'package:rendezvous/Components/modals.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/View/Guest/Guest.dart';
import 'package:rendezvous/View/MainMenu/Scan/Scan.dart';
import 'package:rendezvous/api/get_programs.dart';
import 'package:rendezvous/api/utils_get.dart';
import 'package:rendezvous/inc/Constants.dart';

import '../../models/db.dart';

Future getInitialData() async {
  await getPrograms();
  await getFilesFromAPI();
  await getUtils();
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainBox!.put(DBKeys.userId, "2636");
    mainBox!.put(DBKeys.cardNo, "2016JM016");

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/leaf.png",
                  width: Get.width,
                ),
              ],
            ),
            br(25),
            Text("Lets Explore",
                style: TextStyle(
                  fontSize: 18,
                )),
            br(10),
            ElevatedButton(
                onPressed: () {
                  Get.to(GuestHome());
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Guest Login"),
                )),
            br(10),
            ElevatedButton(
                onPressed: () {
                  //Get.to(ParticipantHomeIndex());
                  Get.to(ScanQR(
                    isLogin: true,
                  ));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Participant Login"),
                )),
            br(20),
            TextButton(
                onPressed: () {
                  showInfoModal(context, "Having problem to login?",
                      "Please contact the support team to get assisted.");
                },
                child: Text("Having problem to login?")),
            // ElevatedButton(
            //     onPressed: () {
            //       FirebaseMessaging messaging = FirebaseMessaging.instance;
            //       messaging.getToken().then((token) {
            //         loginFromAPI("2016JM002", token);
            //       });
            //     },
            //     child: Text("Login"))
          ],
        ),
        Positioned(
          bottom: 0,
          child: Image.asset(
            "assets/images/homeBottom.png",
            width: Get.width,
          ),
        )
      ],
    ));
  }
}
