import 'package:rendezvous/inc/Constants.dart';

String getStudentName(String id) {
  return studentsBox!.get(id, defaultValue: {"name": "Unknown"})["name"];
}
