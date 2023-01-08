import 'dart:convert';

import 'package:rendezvous/inc/Constants.dart';
import 'package:http/http.dart' as http;

Future<bool> getAllParticipations() async {
  try {
    var res = await http.get(
      Uri.parse(NEW_API_ROOT + "participation/get.php"),
    );
    if (res.statusCode == 200) {
      var decode = json.decode(res.body);
      if (decode['status'] == "available") {
        List prs = decode['data'];
        for (Map pr in prs) {
          participationBox!.put(pr['id'], pr);
        }
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
