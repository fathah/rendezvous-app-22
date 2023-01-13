import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rendezvous/Functions/glocalPayFunctions.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/models/db.dart';
import 'package:rendezvous/models/glocal_coin.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  //static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    var numb = numKeyBox!.get('amount');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Glocal Coin'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            br(25),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
            br(10),
            Text(
                "You pay: ₹ ${numb != null && numb.length > 0 ? int.parse(numb) * 2 : 0}"),
            br(15),
            ElevatedButton(
                onPressed: openCheckout,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Text('Pay Now'),
                )),
            br(20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "As the transaction is held through the Blockchain system, it may take a few minutes to verify the blocks. Please be patient.",
                textAlign: TextAlign.center,
                style: TextStyle(color: MAIN_GREEN),
              ),
            ),
          ])),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_vMCwQQvUnGzaAu',
      'amount': (int.parse(numKeyBox!.get("amount")) * 2) * 100,
      'name': mainBox!.get("userName"),
      'description': 'Buy Glocal Coin',
      'external': {
        'wallets': ['paytm', 'gpay', 'phonepe']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Get.back();
    int currentAmount = int.parse(numKeyBox!.get("amount")) +
        int.parse(mainBox!.get(DBKeys.walletBalance));
    mainBox!.put(DBKeys.walletBalance, currentAmount.toString());
    snackBar(
      title: "Payment Successful",
      body: "You have successfully bought Glocal Coin. ",
    );
    await updateUserWallet().then((value) async {
      await GCTransaction().newTransaction(mainBox!.get(DBKeys.userId),
          currentAmount.toString(), 'Buy Glocal Coin');
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    snackBar(
        title: "Payment Failed",
        body: "Failed to buy Glocal Coin. Please try again later.",
        color: MAIN_ORANGE);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    snackBar(
      title: "Payment",
      body: "Payment was made using external wallet.",
    );
  }
}
