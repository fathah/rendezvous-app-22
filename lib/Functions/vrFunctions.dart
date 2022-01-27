import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rendezvous/inc/Constants.dart';

Future<String> registerVR(entryUserId) async {
  var res = await http.post(Uri.parse(ROOT_URL + "/registerVR.php"), body: {
    "api": API_KEY,
    "userid": entryUserId,
    "registrarid": mainBox!.get("userId"),
  });

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "DONE") {
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
