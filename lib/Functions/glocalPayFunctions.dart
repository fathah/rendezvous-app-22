import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/inc/Constants.dart';

Future<String> updateUserWallet() async {
  var res = await http.post(Uri.parse(ROOT_URL + "/updateUser.php"), body: {
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

Future<String> newTransaction(receiver, amount,
    {sender, status = "completed", remarks = "", reference}) async {
  var res = await http.post(Uri.parse(ROOT_URL + "/newTransaction.php"), body: {
    "api": API_KEY,
    "sender": sender ?? mainBox!.get("userId"),
    "receiver": receiver,
    "amount": amount,
    "status": status,
    "remarks": remarks,
    "reference": reference ??
        "${DateTime.now().millisecondsSinceEpoch}-${mainBox!.get("userId")}_${mainBox!.get("userName")}",
  });

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "TRANSACTIONDONE") {
      getTransactionFromAPI();
      return "SUCCESS";
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}

Future<String> sendGlocalCoin(receiver, amount,
    {sender, status = "completed", remarks = "", reference}) async {
  var res = await http.post(Uri.parse(ROOT_URL + "/sendGlocalCoin.php"), body: {
    "api": API_KEY,
    "sender": sender ?? mainBox!.get("userId"),
    "receiver": receiver,
    "amount": amount,
    "status": status,
    "remarks": remarks,
    "reference": reference ??
        "GPay/${mainBox!.get("userId")}/${DateTime.now().millisecondsSinceEpoch}",
  });

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "TRANSACTIONDONE") {
      getTransactionFromAPI();
      return "SUCCESS";
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}

Future checkGlocalPayUser(cardId) async {
  var res = await http.post(Uri.parse(ROOT_URL + "/getUserdata.php"),
      body: {"api": API_KEY, "userid": cardId});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      return decode['data'];
    } else {
      return "NOT_AVAILABLE";
    }
  } else {
    return "NO_CONNECTION";
  }
}
