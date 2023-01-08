import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rendezvous/Components/GeometryContainer.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/View/MainMenu/Scan/Scan.dart';
import 'package:rendezvous/inc/Constants.dart';

Future getTransactions() async {
  if (mainBox!.get("transactions") != null) {
    return mainBox!.get("transactions");
  } else {
    var res = await getTransactionFromAPI();
    if (res == "FAILED") {
      return [];
    } else {
      return res;
    }
  }
}

// ignore: must_be_immutable
class GlocalPay extends StatelessWidget {
  bool isHome = false;
  GlocalPay({Key? key, this.isHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            GeometryContainer(child: Container()),
            Positioned(
                right: 25,
                top: 45,
                left: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isHome
                        ? brw(0)
                        : IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context)),
                    InkWell(
                        onTap: () {
                          Get.to(ScanQR());
                        },
                        child: CircleAvatar(
                            radius: 25,
                            backgroundColor: MAIN_ORANGE,
                            child: Icon(Icons.qr_code_scanner_outlined)))
                  ],
                )),
            Container(
              margin:
                  EdgeInsets.only(top: Get.height * 0.15, left: 25, right: 25),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 4),
                    blurRadius: 30,
                  )
                ],
                color: Colors.grey.shade200.withOpacity(0.5),
                image: DecorationImage(
                  image: AssetImage('assets/images/card.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Glocal Pay", style: TextStyle(color: Colors.black)),
                      Image.asset(
                        "assets/images/glocalcoin.gif",
                        height: 25,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "2022 4693  ${mainBox!.get('cardNo').split('JM')[0]} ${mainBox!.get('cardNo').split('JM')[1]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      brw(20),
                      Text("03/23", style: TextStyle(color: Colors.black))
                    ],
                  ),
                  br(5),
                  Text(mainBox!.get('userName') ?? " ",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  br(25)
                ],
              ),
            ),
          ],
        ),
        br(35),
        Center(
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 4),
                  blurRadius: 30,
                )
              ],
            ),
            child: Column(
              children: [
                QrImage(
                  data: "${mainBox!.get('cardNo')}@glocalpay",
                  version: QrVersions.auto,
                  size: 200.0,
                  foregroundColor: MAIN_GREEN,
                  errorCorrectionLevel: QrErrorCorrectLevel.Q,
                ),
                br(5),
                Text("Scan QR Code get paid",
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
        br(20),
        Divider(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Recent Transcations",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        FutureBuilder(
            future: getTransactions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      br(50),
                      SpinKitFadingFour(
                        color: MAIN_GREEN,
                        size: 50,
                      ),
                      br(10),
                      Text("Getting Transactions")
                    ],
                  ),
                );
              } else if (!snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      br(50),
                      Icon(Icons.toll, color: MAIN_ORANGE),
                      br(10),
                      Text("No Transactions")
                    ],
                  ),
                );
              } else {
                var data = snapshot.data as List;

                return MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSender =
                            data[index]['senderId'] == mainBox!.get('userId');
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              transactionDetails(context, data[index]);
                            },
                            leading: CircleAvatar(
                                backgroundColor: MAIN_ORANGE.withOpacity(0.2),
                                child: Icon(
                                  Icons.payment_outlined,
                                  color: MAIN_ORANGE,
                                )),
                            title: Text(isSender
                                ? data[index]['receiverName'] ?? ""
                                : data[index]['senderName'] ?? ""),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isSender ? "-" : "+",
                                  style: TextStyle(
                                    color: isSender
                                        ? Colors.red[700]
                                        : Colors.green[700],
                                  ),
                                ),
                                SvgPicture.asset(
                                    "assets/images/svg/glocalcoin.svg",
                                    color: isSender
                                        ? Colors.red[700]
                                        : Colors.green[700],
                                    height: 15),
                                brw(1),
                                Text(
                                  "${data[index]['amount']}",
                                  style: TextStyle(
                                    color: isSender
                                        ? Colors.red[700]
                                        : Colors.green[700],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            }),
      ]),
    ));
  }

  transactionDetails(context, data) {
    bool isSender = data['senderId'] == mainBox!.get('userId');
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Transaction Details",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                br(10),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SvgPicture.asset(
                    "assets/images/svg/glocalcoin.svg",
                    color: MAIN_GREEN,
                    height: 30,
                  ),
                  brw(2),
                  Text(
                    "${data['amount']}",
                    style: TextStyle(
                      fontSize: 30,
                      color: MAIN_GREEN,
                    ),
                  ),
                ]),
                br(10),
                Text("Sender", style: TextStyle(color: MAIN_ORANGE)),
                Text("${data['senderName']}"),
                br(5),
                Text("Receiver", style: TextStyle(color: MAIN_ORANGE)),
                Text("${data['receiverName']}"),
                br(5),
                Text("Transaction Type", style: TextStyle(color: MAIN_ORANGE)),
                Text("${isSender ? 'Debit' : 'Credit'}"),
                br(5),
                Text("Reference Id", style: TextStyle(color: MAIN_ORANGE)),
                Text("${data['reference']}"),
                br(5),
                Text("Remarks", style: TextStyle(color: MAIN_ORANGE)),
                Text("${data['remarks']}"),
                br(5),
              ],
            ),
          );
        });
  }
}
