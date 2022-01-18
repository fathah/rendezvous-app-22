import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rendezvous/inc/Constants.dart';

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

Future getFeeds() async {
  String url = "https://manzilmedia.net/apps/rendezvous/getJSON.php?file=feeds";
  final response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}

Future getJSON(File file) async {
  final response = await file.readAsString();
  return json.decode(response);
}

Future getJSONFromAPI(String fileType) async {
  String url =
      "https://manzilmedia.net/apps/rendezvous/getJSON.php?file=$fileType";
  final response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}

Future<String> getUserDataFromAPI(cardId) async {
  var res = await http.post(Uri.parse(ROOT_URL + "/getUserdata.php"),
      body: {"api": API_KEY, "userid": cardId});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      mainBox!.put("userName", decode['data']['user_name']);
      mainBox!.put("walletBalance", decode['data']['user_wallet']);
      mainBox!.put("userType", decode['data']['user_type']);
      mainBox!.put("pin", decode['data']['user_pin']);
      return "SUCCESS";
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}

Future getTransactionFromAPI() async {
  var res = await http.post(Uri.parse(ROOT_URL + "/getTransactions.php"),
      body: {"api": API_KEY, "userid": mainBox!.get('userId')});

  if (res.statusCode == 200) {
    var decode = json.decode(res.body);
    if (decode['statusMsg'] == "AVAILABLE") {
      mainBox!.put("transactions", decode['data']);
      return decode['data'];
    } else {
      return "FAILED";
    }
  } else {
    return "NO_CONNECTION";
  }
}

Future getProgramsFromAPI() async {
  var program = await getJSONFromAPI('program');
  var programList = await getJSONFromAPI('programlist');
  var teamScore = await getJSONFromAPI('teamScore');

  programBox!.put("programs", program);
  programBox!.put("programList", programList);
  mainBox!.put("teamScore", teamScore);
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
