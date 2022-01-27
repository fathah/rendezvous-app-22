import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rendezvous/Components/NumKeyPad.dart';
import 'package:rendezvous/Functions/glocalPayFunctions.dart';
import 'package:rendezvous/View/MainMenu/GlocalPay/Success.dart';
import 'package:rendezvous/View/Participant/Index.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/strings.dart';

// ignore: must_be_immutable
class EnterPIN extends StatefulWidget {
  String amount;
  String receiver;
  String remark = "";
  EnterPIN(
      {Key? key,
      required this.amount,
      required this.receiver,
      this.remark = ""})
      : super(key: key);

  @override
  _EnterPINState createState() => _EnterPINState();
}

class _EnterPINState extends State<EnterPIN> {
  @override
  void initState() {
    numKeyBox!.put('num', "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            child: ValueListenableBuilder(
              valueListenable: numKeyBox!.listenable(),
              builder: (context, Box box, widget) {
                var pin = box.get('num');
                return Column(
                  children: [
                    br(Get.height * 0.2),
                    Text(
                      pin != null && pin.length > 4
                          ? "Invalid PIN. Please enter only 4 digits."
                          : "",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    br(5),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          singlePin(pin, 0),
                          singlePin(pin, 1),
                          singlePin(pin, 2),
                          singlePin(pin, 3),
                        ],
                      ),
                    ),
                    br(25),
                    TextButton(
                      onPressed: () {
                        Get.offAll(ParticipantHomeIndex());
                      },
                      child: Text("Abort Transaction"),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        Container(
            child: Column(
          children: [
            Text("SECURED BY",
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 5, fontSize: 12)),
            Center(
              child: Image.asset(
                "assets/images/secured.png",
                width: Get.width * 0.7,
              ),
            ),
            br(50),
            Text(
              "Please enter your 4 digit PIN",
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
            br(10),
            NumKeyPad(onDone: () {
              if (numKeyBox!.get('num') == mainBox!.get('pin')) {
                transfering();
                print(
                    "${widget.receiver}, ${widget.amount},remarks: ${widget.remark}");
                sendGlocalCoin(widget.receiver, widget.amount,
                        remarks: widget.remark)
                    .then((value) {
                  Get.offAll(PaymentSuccess(
                    isSuccess: value == "SUCCESS",
                  ));
                });
              } else {
                snackBar(
                    title: "Sorry, PIN is incorrect",
                    body:
                        "If you don't remember your PIN, please contact Glocal support team.",
                    color: Colors.red[600]);
              }
            })
          ],
        ))
      ],
    ));
  }

  singlePin(pin, index) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: Center(
        child: Text(
          "${pin != null && pin.length > index ? pin.length > index + 1 ? "◉" : pin[index] : ""}",
          style: TextStyle(
            fontSize: 22,
            color: MAIN_ORANGE,
          ),
        ),
      ),
    );
  }

  transfering() {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (ctx) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                br(50),
                SpinKitDoubleBounce(
                  color: MAIN_ORANGE,
                  size: 50,
                ),
                br(20),
                Text("Payment in progress..."),
                br(50),
                Text("SECURED BY",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 5, fontSize: 12)),
                Center(
                  child: Image.asset(
                    "assets/images/secured.png",
                    width: Get.width * 0.5,
                  ),
                ),
                br(50),
              ],
            ),
          );
        });
  }
}
