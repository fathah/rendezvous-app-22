import 'dart:convert';

import 'package:rendezvous/api/get_user_data.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:rendezvous/models/db.dart';

Future<bool> addNewTransactionToDB(
    String to, String amount, String message, bool isNew) async {
  try {
    String userId = mainBox!.get(DBKeys.userId);
    var res = await http
        .post(Uri.parse(NEW_API_ROOT + "glocalCoin/addTransaction.php"), body: {
      'api': API_KEY,
      'from': isNew ? '3' : userId,
      'to': to,
      'amount': amount,
      'message': message
    });
    if (res.statusCode == 200) {
      var decode = json.decode(res.body);
      if (decode['status'] == "success") {
        getUserData();
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
