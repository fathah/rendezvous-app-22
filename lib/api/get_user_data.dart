import 'dart:convert';

import 'package:rendezvous/inc/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:rendezvous/models/db.dart';

Future<bool> getUserData() async {
  try {
    String userId = mainBox!.get(DBKeys.userId);
    var res = await http.get(
      Uri.parse(NEW_API_ROOT + "students/get.php?id=$userId"),
    );
    if (res.statusCode == 200) {
      var decode = json.decode(res.body);
      if (decode['status'] == "available") {
        Map data = decode['data'][0];
        mainBox!.put(DBKeys.campus, data['campus']);
        mainBox!.put(DBKeys.team, data['team']);
        mainBox!.put(DBKeys.userName, data['name']);      
        mainBox!.put(DBKeys.section, data['section']);
        mainBox!.put(DBKeys.point, data['point']);
        mainBox!.put(DBKeys.walletBalance, data['walletBalance']);
        mainBox!.put(DBKeys.userType, data['userType']);
        mainBox!.put(DBKeys.pin, data['userPin']);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
