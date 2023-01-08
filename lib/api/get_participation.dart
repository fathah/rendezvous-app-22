import 'dart:convert';

import 'package:rendezvous/inc/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:rendezvous/models/db.dart';

Future<bool> getParticipation() async {
  try {
    String jamiaId = mainBox!.get(DBKeys.cardNo) ?? "";
    var res = await http.get(
      Uri.parse(NEW_API_ROOT + "participation/get.php?jamiaId=$jamiaId"),
    );
    if (res.statusCode == 200) {
      var decode = json.decode(res.body);
      if (decode['status'] == "available") {
        mainBox!.put(DBKeys.participations, decode['data']);
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
