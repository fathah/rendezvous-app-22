import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rendezvous/inc/Constants.dart';

Future<String> loginFromAPI(cardId, token) async {
  var res = await http.post(Uri.parse(ROOT_URL + "/getUserdata.php"),
      body: {"api": API_KEY, "userid": cardId});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      mainBox!.put("userId", decode['data']['user_id']);
      mainBox!.put("userName", decode['data']['user_name']);
      mainBox!.put("cardNo", cardId);
      mainBox!.put("walletBalance", decode['data']['user_wallet']);
      mainBox!.put("userType", decode['data']['user_type']);
      mainBox!.put("pin", decode['data']['user_pin']);
      await http.post(Uri.parse(ROOT_URL + "/addDeviceToken.php"), body: {
        "api": API_KEY,
        "userid": decode['data']['user_id'],
        "deviceId": token
      });

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
