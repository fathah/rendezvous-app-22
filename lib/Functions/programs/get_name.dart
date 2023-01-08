import 'package:rendezvous/inc/Constants.dart';

String getProgramName(String id) {
  return programBox!.get(id, defaultValue: {"name": "Unknown"})["name"];
}
