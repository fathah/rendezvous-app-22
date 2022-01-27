import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

// ignore: must_be_immutable
class SingleProgram extends StatelessWidget {
  var data;
  SingleProgram({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${data['name']}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['name'],
                  style: TextStyle(fontSize: 25, color: MAIN_ORANGE)),
              Text("${getSection(data['section'])}",
                  style: TextStyle(color: Colors.grey)),
              br(25),
              if (data['rules'] != null) ...[
                Text('Code of Conduct',
                    style: TextStyle(color: MAIN_GREEN, fontSize: 20)),
                br(5),
                Text(
                  data['rules'],
                  style: TextStyle(fontFamily: noto, height: 1.5),
                ),
              ],
              br(25),
              if (data['topics'] != null) ...[
                Text('Topics',
                    style: TextStyle(color: MAIN_GREEN, fontSize: 20)),
                br(5),
                Text(
                  data['topics'],
                  style: TextStyle(fontFamily: noto, height: 1.5),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
