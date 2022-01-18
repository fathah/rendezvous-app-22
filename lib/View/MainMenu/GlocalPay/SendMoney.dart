import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rendezvous/Components/NumKeyPad.dart';
import 'package:rendezvous/Functions/glocalPayFunctions.dart';
import 'package:rendezvous/View/MainMenu/GlocalPay/PIN.dart';
import 'package:rendezvous/View/MainMenu/GlocalPay/Transfering.dart';
import 'package:rendezvous/inc/Constants.dart';

class SendMoney extends StatefulWidget {
  String? amount;
  var receiverData;
  SendMoney({Key? key, this.amount, this.receiverData}) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  String remarks = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                color: MAIN_ORANGE,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sending Glocal Coin to",
                      style: TextStyle(color: Colors.white),
                    ),
                    br(10),
                    Text(
                      "${widget.receiverData['user_name']}",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    br(10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white30),
                      child: Text(
                        "${widget.receiverData['user_card_no']}@glocalpay",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    br(20),
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
                                        color: Colors.white,
                                        height: 40,
                                      ),
                                      brw(2),
                                      Text(
                                        "${numb != null && numb.length > 0 ? numb : 0}",
                                        style: TextStyle(
                                          fontSize: Get.height * 0.05,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ]),
                                br(4),
                                Text(
                                  "Current Value: ₹ ${numb != null && numb.length > 0 ? int.parse(numb) * 2 : 0}",
                                  style: TextStyle(color: Colors.white54),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    br(15),
                    Container(
                        width: Get.width * 0.5,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white12),
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(color: Colors.white),
                          onChanged: (val) {
                            setState(() => remarks = val);
                          },
                          decoration: InputDecoration(
                            hintText: "Add note..",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ))
                  ],
                ),
              )),
              Container(
                child: Column(
                  children: [
                    br(10),
                    Text(
                      "Enter the amount",
                      style: TextStyle(color: Colors.black54),
                    ),
                    br(10),
                    NumKeyPad(onDone: () {
                      if (numKeyBox!.get('num').length < 1 ||
                          int.parse(numKeyBox!.get('num') ?? "0") < 1) {
                        snackBar(
                            title: "Invalid Amount",
                            body: "Please enter a valid amount",
                            color: Colors.red[700]);
                      } else if (int.parse(numKeyBox!.get('num') ?? "0") >
                          int.parse(mainBox!.get('walletBalance') ?? "0")) {
                        snackBar(
                            title: "Not Enough Balance",
                            body:
                                "Please recharge the wallet to send Glocal Coin",
                            color: Colors.red[700]);
                      } else {
                        confirmPayment();
                      }
                    })
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 70,
            left: 25,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white24,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.white),
              ),
            ))
      ],
    ));
  }

  confirmPayment() {
    var numb = numKeyBox!.get('num');
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                br(25),
                Text("Are you sure, do you want to confirm the payment?",
                    style: TextStyle(color: MAIN_GREEN)),
                br(10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(
                    "assets/images/svg/glocalcoin.svg",
                    color: Colors.green[700],
                    height: 40,
                  ),
                  brw(2),
                  Text(
                    "${numb != null && numb.length > 0 ? numb : 0}",
                    style: TextStyle(
                      fontSize: Get.height * 0.05,
                      color: Colors.green[700],
                    ),
                  ),
                ]),
                br(5),
                Text(
                  "${widget.receiverData['user_name']}",
                  style: TextStyle(fontSize: 20, color: MAIN_ORANGE),
                ),
                br(10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black12),
                  child: Text(
                    "${widget.receiverData['user_card_no']}@glocalpay",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                br(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Get.to(EnterPIN(
                        amount: numb,
                        receiver: widget.receiverData['user_id'],
                        remark: remarks,
                      ));
                    },
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock_outline,
                            ),
                            brw(4),
                            Text("Pay Securely")
                          ],
                        )),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MAIN_GREEN),
                    ),
                  ),
                ),
                br(40),
              ],
            ),
          );
        });
  }

  transferPage() {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransferingGlocalCoin();
        });
  }
}
