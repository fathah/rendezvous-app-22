import 'package:flutter/material.dart';
import 'package:rendezvous/View/MainMenu/GlocalVR/ConfirmTicket.dart';
import 'package:rendezvous/View/MainMenu/Scan/Scan.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/strings.dart';

selectUserForVR(context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              br(40),
              Text("Registering For"),
              br(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Get.to(ConfirmTicket(receiverData: {
                          'user_name': mainBox!.get('userName'),
                          'user_id': mainBox!.get('userId'),
                          'user_card_no': mainBox!.get('cardNo'),
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text("Yourself"),
                      )),
                  brw(15),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(MAIN_GREEN),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Get.to(ScanQR(isVR: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text("Other Student"),
                      )),
                ],
              ),
              br(40),
            ],
          ),
        );
      });
}
