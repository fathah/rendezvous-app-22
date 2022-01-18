import 'package:flutter/material.dart';
import 'package:rendezvous/Components/modals.dart';
import 'package:rendezvous/View/MainMenu/Scan/Scan.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/strings.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Guest Login"),
                )),
            br(10),
            ElevatedButton(
                onPressed: () {
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
