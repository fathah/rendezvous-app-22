import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rendezvous/Functions/vrFunctions.dart';
import 'package:rendezvous/View/MainMenu/GlocalVR/Register.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wifi_connector/wifi_connector.dart';

class GlocalVR extends StatefulWidget {
  const GlocalVR({Key? key}) : super(key: key);

  @override
  _GlocalVRState createState() => _GlocalVRState();
}

class _GlocalVRState extends State<GlocalVR> {
  @override
  void initState() {
    super.initState();
    getVRDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: Get.height * 0.3,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/vrbg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 45,
                left: 15,
                child: IconButton(
                    tooltip: "Go Back",
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context)),
              ),
              Positioned(
                top: 45,
                right: 15,
                child: IconButton(
                    tooltip: "Settings",
                    icon: Icon(Icons.settings),
                    onPressed: () => showSettings()),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: Get.height * 0.25, left: 25, right: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ValueListenableBuilder(
                    valueListenable: vrBox!.listenable(),
                    builder: (context, Box box, widget) {
                      var data = box.get('vrData');
                      List waiting = data
                          .where((e) => e['vr_is_completed'] == '0')
                          .toList();
                      List finalList = [];

                      for (var i in data) {
                        if (waiting.contains(i)) {
                          i['queu'] = waiting.indexOf(i);
                        }
                        finalList.add(i);
                      }
                      finalList = finalList
                          .where((e) =>
                              e['vr_registered_by'] == mainBox!.get('userId'))
                          .toList();

                      return Column(
                        children: [
                          // br(20),
                          // Text(
                          //   "Glocal VR",
                          //   style: TextStyle(fontSize: 20, color: MAIN_ORANGE),
                          // ),
                          // Text("Experience the mini metaverse"),
                          // br(20),
                          // ElevatedButton(
                          //     onPressed: () {},
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(10.0),
                          //       child: Text(data.length > 0
                          //           ? "Register Another"
                          //           : "Register Now"),
                          //     )),
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/vrtop.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: Colors.white,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                onTap: () {
                                  selectUserForVR(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),

                          br(25),
                          if (finalList.length > 0) ...[
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                width: double.infinity,
                                child: Text("Your Registrations",
                                    style: TextStyle(color: MAIN_ORANGE))),
                            Container(
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: finalList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var queu = finalList[index]['queu'] ?? 0;
                                    return Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.3))),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: ListTile(
                                          leading: Icon(
                                              Icons.local_activity_outlined,
                                              color: MAIN_GREEN),
                                          title: Text(
                                              "${finalList[index]['vr_user_name']}"),
                                          subtitle: (finalList[index]
                                                          ['vr_is_completed'] ==
                                                      "0" &&
                                                  queu < 11)
                                              ? Text("Get ready for the entry!",
                                                  style: TextStyle(
                                                      color: MAIN_GREEN))
                                              : finalList[index]
                                                          ['vr_is_completed'] ==
                                                      "2"
                                                  ? Text(
                                                      "Cancelled",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.red[500]),
                                                    )
                                                  : Text(finalList[index][
                                                              'vr_is_completed'] ==
                                                          "1"
                                                      ? "Completed"
                                                      : "GVR/${finalList[index]['vr_id']}/${finalList[index]['vr_user_card_no']}"),
                                          onTap: () {
                                            vrDescriptionSheet(
                                                finalList[index]);
                                          },
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 25,
                                          ),
                                          trailing: finalList[index]
                                                      ['vr_is_completed'] ==
                                                  "2"
                                              ? Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                )
                                              : finalList[index]
                                                          ['vr_is_completed'] ==
                                                      "1"
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                    )
                                                  : Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.timer,
                                                            color: MAIN_ORANGE),
                                                        brw(3),
                                                        Text(
                                                            "${finalList[index]['queu'] + 1}")
                                                      ],
                                                    ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                          br(25),
                          Text(
                            "Download VR Player",
                            style: TextStyle(color: Colors.grey),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              onPressed: () {
                                if (Platform.isIOS) {
                                  launch(
                                      "https://play.google.com/store/apps/details?id=com.glocal.vr");
                                } else {
                                  launch(
                                      "https://play.google.com/store/apps/details?id=com.xojot.vrplayer");
                                }
                              },
                              child: Text("Click to Download")),
                          br(25)
                        ],
                      );
                    }),
              ),
            ],
          ),
          br(30)
        ],
      ),
    ));
  }

  vrDescriptionSheet(data) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return EntryDetails(
            data: data,
          );
        });
  }

  showSettings() {
    List? utils = mainBox!.get('utils');
    String? serverUrl;
    if (utils != null) {
      utils.forEach((element) {
        if (element['util_name'] == 'vrserver') {
          serverUrl = element['util_value'];
        }
      });
    }

    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Glocal VR Settings",
                  style: TextStyle(color: MAIN_ORANGE, fontSize: 20),
                ),
                br(12),
                Text("Glocal Server URL:",
                    style: TextStyle(color: MAIN_GREEN, fontSize: 13)),
                Text(
                  serverUrl ?? "Not Updated",
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: Text("Update Server")),
                    brw(10),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(MAIN_GREEN),
                        ),
                        onPressed: serverUrl != null
                            ? () async {
                                launch(serverUrl! + "/vr/glocalvr.mp4");
                              }
                            : null,
                        child: Text("Connect to Server")),
                  ],
                ),
                br(5),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Open VR Player"),
                    )),
                br(12),
                br(35)
              ],
            ),
          );
        });
  }
}

// ignore: must_be_immutable
class EntryDetails extends StatelessWidget {
  var data;
  EntryDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          br(20),
          Text("Entry Details",
              style: TextStyle(color: MAIN_ORANGE, fontSize: 22)),
          br(10),
          Text("Name",
              style: TextStyle(
                color: Colors.black45,
              )),
          Text("${data['vr_user_name']}", style: TextStyle(fontSize: 18)),
          br(8),
          Text("Ticket ID",
              style: TextStyle(
                color: Colors.black45,
              )),
          Text("GVR/${data['vr_id']}/${data['vr_user_card_no']}",
              style: TextStyle(fontSize: 18)),
          br(8),
          Text("Payment Status",
              style: TextStyle(
                color: Colors.black45,
              )),
          Text(
              "${data['vr_payment_status'][0].toUpperCase()}${data['vr_payment_status'].substring(1).toLowerCase()}",
              style: TextStyle(fontSize: 18)),
          br(8),
          if (data['vr_is_completed'] == "0") ...[
            Text("Entry Queue",
                style: TextStyle(
                  color: Colors.black45,
                )),
            Text("${data['queu']} people remaining before you.",
                style: TextStyle(fontSize: 18)),
            br(8),
          ],
          Text("Entry QR",
              style: TextStyle(
                color: Colors.black45,
              )),
          br(5),
          QrImage(
            padding: EdgeInsets.all(0),
            data: "${data['vr_id']}@glocalpay",
            version: QrVersions.auto,
            size: 150.0,
            foregroundColor: Colors.black,
            errorCorrectionLevel: QrErrorCorrectLevel.Q,
          ),
          br(5),
          br(30)
        ],
      ),
    );
  }
}
