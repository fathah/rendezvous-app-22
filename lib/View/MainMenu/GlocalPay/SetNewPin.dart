import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rendezvous/Functions/glocalPayFunctions.dart';
import 'package:rendezvous/View/Participant/Index.dart';
import 'package:rendezvous/inc/Constants.dart';

class SetNewPIN extends StatefulWidget {
  const SetNewPIN({Key? key}) : super(key: key);

  @override
  _SetNewPINState createState() => _SetNewPINState();
}

class _SetNewPINState extends State<SetNewPIN> {
  final formKey = GlobalKey<FormState>();

  bool hide1 = true;
  bool hide2 = true;
  String? pin;
  String? pin2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set New PIN'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              br(30),
              TextFormField(
                maxLength: 4,
                obscureText: hide1,
                keyboardType: TextInputType.number,
                decoration: formDeco('New PIN', hide1, 1),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid PIN';
                  }
                  if (value.length != 4) {
                    return 'PIN must be 4 digits';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    pin = value;
                  });
                },
              ),
              br(10),
              TextFormField(
                maxLength: 4,
                obscureText: hide2,
                keyboardType: TextInputType.number,
                decoration: formDeco('Repeat PIN', hide1, 2),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (pin != pin2) {
                    return 'PINs do not match';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    pin2 = value;
                  });
                },
              ),
              br(10),
              ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (formKey.currentState!.validate()) {
                      mainBox!.put("pin", pin);
                      settingPIN();
                      updateUserWallet().then((value) {
                        Get.offAll(ParticipantHomeIndex());
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Set PIN'),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration formDeco(label, hide, index) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: MAIN_ORANGE,
        width: 2,
      ),
    );
    return InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              if (index == 1)
                hide1 = !hide1;
              else
                hide2 = !hide2;
            });
          },
        ),
        labelText: label,
        hintText: label,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border);
  }

  settingPIN() {
    return showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              br(30),
              SpinKitDoubleBounce(
                color: MAIN_ORANGE,
                size: 50,
              ),
              br(10),
              Text("Setting PIN..."),
              br(30),
            ],
          );
        });
  }
}
