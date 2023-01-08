import 'dart:convert';

import 'package:rendezvous/inc/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:rendezvous/models/db.dart';

Future<bool> getNotifications() async {
  try {
    var res = await http.get(
      Uri.parse(NEW_API_ROOT + "notification/get.php"),
    );
    if (res.statusCode == 200) {
      var decode = json.decode(res.body);
      if (decode['status'] == "available") {
        List prs = decode['data'];
        mainBox!.put(DBKeys.notifications, prs);
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
