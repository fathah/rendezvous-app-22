import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rendezvous/Functions/glocalPayFunctions.dart';
import 'package:rendezvous/Functions/login.dart';
import 'package:rendezvous/View/MainMenu/GlocalPay/SendMoney.dart';
import 'package:rendezvous/View/MainMenu/GlocalVR/ConfirmTicket.dart';
import 'package:rendezvous/View/Participant/Index.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/models/db.dart';

// ignore: must_be_immutable
class ScanQR extends StatefulWidget {
  bool isLogin = false;
  bool isVR = false;
  ScanQR({Key? key, this.isLogin = false, this.isVR = false}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  late FirebaseMessaging messaging;
  String? token = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    //NOTIFICATION INITIALIZATION
    if (mainBox!.get(DBKeys.userId) == null ||
        mainBox!.get(DBKeys.cardNo) == null) {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        setState(() {
          token = value;
        });
      });
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (widget.isLogin) {
        if (!scanData.code!.contains("@jamiamadeenathunnoor") ||
            !scanData.code!.contains("JM")) {
          setState(() {
            resp =
                "This QR code is invalid in Rendezvous/Glocal Media. Please scan the code available in your ID card.";
            loading = false;
          });
        } else {
          setState(() {
            resp = "Logging in. Please wait.";
            loading = true;
          });
          String cardId = scanData.code!.split("@")[0];
          loginFromAPI(cardId, token).then((value) {
            if (value == "SUCCESS") {
              Get.offAll(() => ParticipantHomeIndex());
            } else if (value == "NO_CONNECTION") {
              setState(() {
                resp = "Oops. Please check your connection.";
                loading = false;
              });
            } else {
              setState(() {
                resp = "Something went wrong. Please contact the support team.";
                loading = false;
              });
            }
          });
        }
      } else {
        if (widget.isVR) {
          if (scanData.code!.contains("@jamiamadeenathunnoor")) {
            String cardId = scanData.code!.split("@")[0];
            Map recUser = checkGlocalPayUser(cardId);
               if (!recUser.containsKey("jamiaId")) {
                setState(() {
                  resp = "Couldn't get this user.";
                  loading = false;
                });
              } else {
                setState(() {
                  resp = "Things getting ready...";
                  loading = false;
                });

                Navigator.pop(context);
                Get.to(ConfirmTicket(
                  receiverData: recUser,
                ));
              }
           
          } else {
            setState(() {
              resp =
                  "This QR code is invalid in Rendezvous/Glocal Media. Please scan the code available in your ID card.";
              loading = false;
            });
          }
        } else {
          if (scanData.code!.contains("@glocalpay")) {
            setState(() {
              resp = "Checking if the user is available in Glocal Pay";
              loading = true;
            });
            String cardId = scanData.code!.split("@")[0];
                        Map recUser = checkGlocalPayUser(cardId);

             if (!recUser.containsKey("jamiaId")) {
                setState(() {
                  resp = "This user is not available in Glocal Pay.";
                  loading = false;
                });
              } else {
                setState(() {
                  resp = "Taking to Glocal Pay.";
                  loading = false;
                });
                numKeyBox!.put('num', "0");
                Navigator.pop(context);
                Get.to(SendMoney(
                  receiverData: recUser,
                ));
              }
           
          } else {
            setState(() {
              resp =
                  "This QR code is not supported in Rendezvous/Glocal Media protocols.";
              loading = false;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  String resp = "Please scan the QR Code";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: QRView(
                overlay: QrScannerOverlayShape(
                  borderColor: Get.theme.primaryColor,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
                key: qrKey,
                onQRViewCreated: _onQRViewCreated),
          ),
          Container(
              height: Get.height * 0.1,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  loading
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : br(10),
                  br(6),
                  Center(
                      child: Text(
                    "$resp",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MAIN_ORANGE,
                    ),
                  )),
                ],
              ))
        ],
      ),
    );
  }
}
