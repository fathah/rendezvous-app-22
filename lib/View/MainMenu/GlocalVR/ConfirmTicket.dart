import 'package:flutter/material.dart';
import 'package:rendezvous/Functions/vrFunctions.dart';
import 'package:rendezvous/View/MainMenu/GlocalVR/GlocalVR.dart';
import 'package:rendezvous/View/Participant/Index.dart';
import 'package:rendezvous/inc/Constants.dart';

// ignore: must_be_immutable
class ConfirmTicket extends StatelessWidget {
  var receiverData;
  ConfirmTicket({Key? key, required this.receiverData}) : super(key: key);
  ValueNotifier isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/vrentry.png',
            width: Get.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                br(15),
                Text("Name", style: TextStyle(color: MAIN_ORANGE)),
                Text("${receiverData['user_name']}",
                    style: TextStyle(fontSize: 18)),
                br(8),
                Text("Jamia ID", style: TextStyle(color: MAIN_ORANGE)),
                Text("${receiverData['user_card_no']}",
                    style: TextStyle(fontSize: 18)),
                br(10),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, isLoad, child) {
                      return ElevatedButton(
                          onPressed: isLoad == false
                              ? () {
                                  isLoading.value = true;
                                  registerVR(receiverData['user_id'])
                                      .then((value) {
                                    isLoading.value = false;
                                    successModal(
                                      context,
                                      value,
                                    );
                                  });
                                }
                              : null,
                          child: Text(isLoad == false
                              ? "Confirm Booking"
                              : "Booking..."));
                    }),
                br(20),
              ],
            ),
          )
        ],
      ),
    );
  }

  successModal(context, res) {
    bool result = res == "SUCCESS";
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                br(20),
                Text(result ? "Booking Successful" : "Booking Failed",
                    style: TextStyle(
                      fontSize: 20,
                      color: result ? MAIN_GREEN : MAIN_ORANGE,
                    )),
                br(10),
                Text(
                    result
                        ? "Your booking has been confirmed. You will be notified once the queue has been cleared. Please keep checking your queue status."
                        : "Your booking has failed. Please try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15)),
                br(10),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(ParticipantHomeIndex());
                    Get.to(GlocalVR());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                    child: Text("Back to Glocal VR"),
                  ),
                ),
                br(30),
              ],
            ),
          );
        });
  }
}
