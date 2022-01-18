import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rendezvous/inc/Constants.dart';

Future<String> d() async {
  var res = await http.post(Uri.parse(ROOT_URL + "/getVRdata.php"), body: {
    "api": API_KEY,
    "userid": mainBox!.get("userId"),
    "wallet": mainBox!.get("walletBalance"),
    "pin": mainBox!.get("pin")
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

Future getVRDataFromAPI() async {
  var res = await http
      .post(Uri.parse(ROOT_URL + "/getVRdata.php"), body: {"api": API_KEY});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      vrBox!.put("vrData", decode['data']);
      return decode['data'];
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}
