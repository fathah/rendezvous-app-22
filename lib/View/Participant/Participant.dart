import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rendezvous/Components/AdCarosal.dart';
import 'package:rendezvous/Components/Programs.dart';
import 'package:rendezvous/Components/SetPin.dart';
import 'package:rendezvous/View/GlocalCoin/GlocalCoin.dart';
import 'package:rendezvous/View/MainMenu/Gallery/Gallery.dart';
import 'package:rendezvous/View/MainMenu/GlocalPay/GlocalPay.dart';
import 'package:rendezvous/View/MainMenu/GlocalVR/GlocalVR.dart';
import 'package:rendezvous/View/MainMenu/Notifications/Notifications.dart';
import 'package:rendezvous/View/MainMenu/Programs/Programs.dart';
import 'package:rendezvous/View/MainMenu/Result/Results.dart';
import 'package:rendezvous/View/MainMenu/Scan/Scan.dart';
import 'package:rendezvous/View/MainMenu/Topics/Topics.dart';
import 'package:rendezvous/View/MainMenu/Watch/Watch.dart';
import 'package:rendezvous/chart.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/models/db.dart';

class ParticipantHome extends StatefulWidget {
  const ParticipantHome({Key? key}) : super(key: key);

  @override
  _ParticipantHomeState createState() => _ParticipantHomeState();
}

class _ParticipantHomeState extends State<ParticipantHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/geometry.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        MAIN_GREEN,
                        MAIN_GREEN.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: Get.height * 0.07,
                    left: Get.width * 0.06,
                    right: Get.width * 0.06,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                mainBox!.get('userName') ?? " ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(GlocalCoin());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: MAIN_ORANGE,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/glocalcoin.gif",
                                        height: 20,
                                      ),
                                      brw(5),
                                      Text(
                                        '${mainBox!.get(DBKeys.walletBalance, defaultValue: "0")}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        br(5),
                        Text(
                          "ID: ${mainBox!.get('cardNo')}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        br(5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                'Individual Score: ${mainBox!.get('indPoint') ?? "0"}',
                                style: TextStyle(color: Colors.white)),
                          ],
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(
                    top: Get.height * 0.19,
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 25,
                  ),
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          topRowItem(
                            "scan",
                            'Scan',
                          ),
                          topRowItem(
                            "pay",
                            'Glocal Pay',
                          ),
                          topRowItem(
                            "result",
                            'Results',
                          ),
                        ],
                      ),
                      br(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          topRowItem(
                            "programs",
                            'Programs',
                          ),
                          topRowItem(
                            "notification",
                            'Notifications',
                          ),
                          topRowItem(
                            "watch",
                            'Watch',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            br(10),
            mainBox!.get('pin') != null && mainBox!.get('pin').length > 0
                ? br(0)
                : SetPINNotice(),
            AdCarosal(),
            br(5),
            Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Overall Results",
                      style: TextStyle(
                        fontSize: 20,
                        color: MAIN_ORANGE,
                      ),
                    ),
                    br(20),
                    TeamChart()
                  ],
                )),
            ParticipantPrograms(),
            br(15),
          ],
        ),
      ),
    );
  }

  Widget topRowItem(icon, title) {
    return Container(
      width: Get.width * 0.25,
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                switch (icon) {
                  case "scan":
                    Get.to(ScanQR());
                    break;
                  case "pay":
                    Get.to(GlocalPay());
                    break;
                  case "vr":
                    Get.to(GlocalVR());
                    break;
                  case "result":
                    Get.to(Results());
                    break;
                  case "watch":
                    Get.to(Watch());
                    break;
                  case "gallery":
                    Get.to(Gallery());
                    break;
                  case "programs":
                    Get.to(Programs());
                    break;
                  case "topics":
                    Get.to(Topics());
                    break;
                  case "notification":
                    Get.to(Notifications());
                    break;
                  default:
                    Get.to(ScanQR());
                }
              },
              child: CircleAvatar(
                backgroundColor: MAIN_GREEN.withOpacity(0.1),
                radius: 30,
                child: Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    "assets/images/svg/$icon.svg",
                  ),
                ),
              ),
            ),
          ),
          br(5),
          Text(
            title,
            style: TextStyle(color: MAIN_GREEN),
          )
        ],
      ),
    );
  }
}
