import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:lottie/lottie.dart';
import 'package:rendezvous/Components/GeometryContainer.dart';
import 'package:rendezvous/Components/NumKeyPad.dart';
import 'package:rendezvous/View/GlocalCoin/UPIPay.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

class GlocalCoin extends StatelessWidget {
  const GlocalCoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glocal Coin'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeometryContainer(
                isOrange: true,
                height: Get.height * 0.2,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      br(10),
                      Text("Available Balance",
                          style: TextStyle(color: Colors.white)),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/svg/glocalcoin.svg",
                            color: Colors.white,
                            height: 40,
                          ),
                          brw(2),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "${mainBox!.get('walletBalance') ?? '0'}",
                              style: TextStyle(
                                fontSize: Get.height * 0.05,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            br(15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () => buyCoinModal(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 15),
                    child: Text("Buy Glocal Coin"),
                  )),
              brw(8),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MAIN_GREEN)),
                  onPressed: () {
                    launchUrl(Uri.parse("https://glocal.markazgarden.org/rendezvous/gcscan"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 15),
                    child: Text("View GC Blocks"),
                  ))
            ]),
            br(30),
            Text(
              "You can view all the transactions held through Glocal Blockchain with GC Scan",
            ),
            Spacer(),
            Center(
              child: Lottie.asset(
                "assets/lottie/coin.json",
                width: Get.width * 0.9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buyCoinModal(context) {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return WillPopScope(
              onWillPop: () {
                Navigator.pop(context);
                numKeyBox!.put('num', "0");
                return Future.value(false);
              },
              child: CoinInput());
        });
  }
}

class CoinInput extends StatefulWidget {
  const CoinInput({Key? key}) : super(key: key);

  @override
  _CoinInputState createState() => _CoinInputState();
}

class _CoinInputState extends State<CoinInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          br(10),
          br(10),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: ValueListenableBuilder(
                valueListenable: numKeyBox!.listenable(),
                builder: (context, Box box, widget) {
                  var numb = box.get('num');

                  return Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/svg/glocalcoin.svg",
                              color: MAIN_GREEN,
                              height: 40,
                            ),
                            brw(2),
                            Text(
                              "${numb != null && numb.length > 0 ? numb : 0}",
                              style: TextStyle(
                                fontSize: Get.height * 0.05,
                                color: MAIN_GREEN,
                              ),
                            ),
                          ]),
                      br(4),
                      Text(
                          "Current Value: ₹ ${numb != null && numb.length > 0 ? int.parse(numb) * 2 : 0}")
                    ],
                  );
                },
              ),
            ),
          ),
          NumKeyPad(onDone: () {
            numKeyBox!.put("amount", numKeyBox!.get("num"));
            Navigator.pop(context);
            numKeyBox!.put("num", "0");
            Get.to(Payment());
          }),
          br(6)
        ],
      ),
    );
  }
}
