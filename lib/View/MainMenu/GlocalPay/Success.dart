import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/View/Participant/Index.dart';
import 'package:rendezvous/inc/Constants.dart';

// ignore: must_be_immutable
class PaymentSuccess extends StatefulWidget {
  bool isSuccess = true;
  PaymentSuccess({Key? key, this.isSuccess = true}) : super(key: key);

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  void initState() {
    super.initState();
    getUserDataFromAPI(mainBox!.get('cardNo'));
    numKeyBox!.put('num', "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.isSuccess
                ? LottieBuilder.asset(
                    "assets/lottie/success.json",
                    width: Get.width * 0.8,
                  )
                : Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: Get.width * 0.3,
                  ),
            br(10),
            Text(widget.isSuccess ? "Payment Successful" : "Payment Failed",
                style: TextStyle(
                    fontSize: 25,
                    color: widget.isSuccess ? MAIN_GREEN : MAIN_ORANGE)),
            br(50),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(ParticipantHomeIndex());
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text("Back to Home"),
                ))
          ],
        ),
      ),
    );
  }
}
