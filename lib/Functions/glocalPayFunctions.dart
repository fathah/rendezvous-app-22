import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/inc/Constants.dart';

import '../models/db.dart';

Future<String> updateUserWallet() async {
  var res = await http.post(Uri.parse(ROOT_URL + "/updateUser.php"), body: {
    "api": API_KEY,
    "userid": mainBox!.get(DBKeys.userId),
    "wallet": mainBox!.get(DBKeys.walletBalance, defaultValue: 0),
    "pin": mainBox!.get(DBKeys.pin, defaultValue: "")
  });

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);

    if (decode['statusMsg'] == "USERDATAUPDATED") {
      return "SUCCESS";
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}


Map checkGlocalPayUser(String cardId) {
  List students =
      studentsBox!.values.where((el) => el['jamiaId'] == cardId).toList();

  if (students.isNotEmpty) {
    return students[0];
  } else {
    return {};
  }
}
