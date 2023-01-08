import 'dart:convert';

import 'package:rendezvous/inc/Constants.dart';
import 'package:http/http.dart' as http;

Future<bool> getAllStudents() async {
  try {
    var res = await http.get(
      Uri.parse(NEW_API_ROOT + "students/get.php"),
    );
    if (res.statusCode == 200) {
      var decode = json.decode(res.body);
      if (decode['status'] == "available") {
        List stds = decode['data'];
        for (Map std in stds) {
          studentsBox!.put(std['id'], std);
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
