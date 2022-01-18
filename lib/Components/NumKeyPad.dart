import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';

class NumKeyPad extends StatelessWidget {
  Function onDone;

  NumKeyPad({Key? key, required this.onDone}) : super(key: key);

  TextEditingController numCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    numCtrl.addListener(() {});

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumKeyPadButton(text: '1'),
              NumKeyPadButton(text: '2'),
              NumKeyPadButton(text: '3'),
            ],
          ),
          br(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumKeyPadButton(text: '4'),
              NumKeyPadButton(text: '5'),
              NumKeyPadButton(text: '6'),
            ],
          ),
          br(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumKeyPadButton(text: '7'),
              NumKeyPadButton(text: '8'),
              NumKeyPadButton(text: '9'),
            ],
          ),
          br(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumButton(
                  icon: Icons.backspace_outlined,
                  onTap: () {
                    numCtrl.text = numCtrl.text.length > 0
                        ? numCtrl.text.substring(0, numCtrl.text.length - 1)
                        : "";
                    numKeyBox!.put("num", numCtrl.text);
                  }),
              NumKeyPadButton(text: '0'),
              NumButton(icon: Icons.check_circle, onTap: onDone),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget NumKeyPadButton({text}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          numCtrl.text += text;
          numKeyBox!.put("num", numCtrl.text);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget NumButton({icon, onTap}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: MAIN_GREEN,
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
