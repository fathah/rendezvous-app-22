import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/models/db.dart';

Future saveJSON(File file, String json) async {
  String url = "https://manzilmedia.net/apps/rendezvous/getJSON.php?file=";
  final response = await http.get(Uri.parse(url + json));
  file.writeAsString(response.body);
}

Future saveToDB(String json) async {
  String url = "https://manzilmedia.net/apps/rendezvous/getJSON.php?file=";
  final response = await http.get(Uri.parse(url + json));
  mainBox!.put(json, response.body);
}

Future getJSON(File file) async {
  final response = await file.readAsString();
  return json.decode(response);
}

Future getTransactionFromAPI() async {
  String userId = mainBox!.get(DBKeys.userId);
  var res = await http.get(
    Uri.parse(NEW_API_ROOT + "glocalCoin/getTransactions.php?userid=$userId"),
  );

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['status'] == "available") {
      mainBox!.put("transactions", decode['data']);
      return decode['data'];
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}

Future getFilesFromAPI() async {
  var res = await http
      .post(Uri.parse(ROOT_URL + "/filesData.php"), body: {"api": API_KEY});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      vrBox!.put("files", decode['data']);
      return decode['data'];
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}

Future getFilesCategoriesFromAPI() async {
  var res = await http.post(Uri.parse(ROOT_URL + "/fileCategories.php"),
      body: {"api": API_KEY});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      vrBox!.put("fileCategories", decode['data']);
      return decode['data'];
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}

Future getFeeds() async {
  var res = await http
      .post(Uri.parse(ROOT_URL + "/getFeeds.php"), body: {"api": API_KEY});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      mainBox!.put("feeds", decode['data']);
      return decode['data'];
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}
