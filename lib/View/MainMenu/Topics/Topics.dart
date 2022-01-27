import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

import 'SingleTopics.dart';

// ignore: must_be_immutable
class Topics extends StatefulWidget {
  Topics({Key? key}) : super(key: key);

  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  List programs = [];

  @override
  void initState() {
    List prList = programBox!.get('programs') ?? [];
    List tempPr = [];
    if (prList.length > 0) {
      prList.forEach((element) {
        if (element['topics'] != null) {
          tempPr.add(element);
        }
      });
      setState(() {
        programs = tempPr;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topics'),
        centerTitle: true,
      ),
      body: programs.length < 1
          ? Center(
              child: Text('No Programs'),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: programs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(programs[index]['name']),
                      subtitle: Text(getSection(programs[index]['section'])),
                      leading:
                          Icon(Icons.description_outlined, color: MAIN_GREEN),
                      onTap: () {
                        Get.to(SingleTopics(data: programs[index]));
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
