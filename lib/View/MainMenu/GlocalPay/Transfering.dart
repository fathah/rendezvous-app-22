import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/strings.dart';

class TransferingGlocalCoin extends StatefulWidget {
  const TransferingGlocalCoin({Key? key}) : super(key: key);

  @override
  _TransferingGlocalCoinState createState() => _TransferingGlocalCoinState();
}

class _TransferingGlocalCoinState extends State<TransferingGlocalCoin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          br(20),
          Text(
            "Sending Glocal Coin",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          br(8),
          SpinKitDoubleBounce(
            color: MAIN_GREEN,
            size: 50,
          ),
          br(20),
        ],
      ),
    );
  }
}
