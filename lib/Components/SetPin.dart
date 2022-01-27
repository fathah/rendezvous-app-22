import 'package:flutter/material.dart';
import 'package:rendezvous/View/MainMenu/GlocalPay/SetNewPin.dart';
import 'package:rendezvous/inc/Constants.dart';

class SetPINNotice extends StatelessWidget {
  const SetPINNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber,
            color: Colors.red,
          ),
          brw(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You have not set the PIN for Glocal Pay. Please set the PIN to use it securely.",
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(SetNewPIN());
                    },
                    child: Text('Set PIN'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
