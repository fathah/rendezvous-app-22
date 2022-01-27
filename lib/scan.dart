import 'dart:io';

import 'package:flutter/material.dart';


class ScanCode extends StatefulWidget {
  @override
  _ScanCodeState createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;
  String result = "";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      // controller!.pauseCamera();
    } else if (Platform.isIOS) {
      //controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    //controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: Text("Scan")
              // QRView(
              //   key: qrKey,
              //   onQRViewCreated: _onQRViewCreated,
              //   overlay: QrScannerOverlayShape(
              //     borderRadius: 25,
              //     borderColor: mainColor,
              //   ),
              // ),
              ),
          Expanded(
            flex: 1,
            child: Center(
              child:  Text('Scan the chest code'),
            ),
          )
        ],
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     if (scanData.code!.contains('Rendezvous')) {
  //       saveLogged();
  //       saveChest(scanData.code!.split('/')[1]);
  //       Navigator.pushReplacement(
  //           context,
  //           FadeRoute(
  //               page: Home(
  //             chest: scanData.code,
  //           )));
  //     } else {
  //       setState(() {
  //         result = scanData;
  //       });
  //     }
  //   });
  // }
}
