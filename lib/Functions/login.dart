import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/models/db.dart';

Future<String> loginFromAPI(cardId, token) async {
  var res = await http.post(Uri.parse(ROOT_URL + "/getUserdata.php"),
      body: {"api": API_KEY, "userid": cardId});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      mainBox!.put(DBKeys.userId, decode['data']['id']);
      mainBox!.put(DBKeys.userName, decode['data']['name']);
      mainBox!.put(DBKeys.cardNo, cardId);
      mainBox!.put(DBKeys.walletBalance, decode['data']['walletBalance']);
      mainBox!.put(DBKeys.userType, decode['data']['userType']);
      mainBox!.put(DBKeys.pin, decode['data']['userPin']);
      await http.post(Uri.parse(ROOT_URL + "/addDeviceToken.php"), body: {
        "api": API_KEY,
        "userid": decode['data']['id'],
        "deviceId": token
      }).catchError((er) => print(er));
      print(mainBox!.keys.toList());
      print(mainBox!.values.toList());
      return "SUCCESS";
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}

Future logoutUser() async {
  var res = await http.post(Uri.parse(ROOT_URL + "/logout.php"),
      body: {"api": API_KEY, 'userid': mainBox!.get("userId")});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    print(decode);
    if (decode['statusMsg'] == "LOGGEDOUT") {
      return "SUCCESS";
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}
