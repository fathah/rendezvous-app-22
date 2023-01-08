import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

import 'SingleTopics.dart';

// ignore: must_be_immutable
class Topics extends StatelessWidget {
  Topics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topics'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: programBox!.listenable(),
        builder: (BuildContext context, Box box, Widget? child) {
          return box.values.isEmpty
              ? Center(
                  child: Text('No Programs'),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Map pr = box.values.elementAt(index);
                      return Card(
                        child: ListTile(
                          title: Text(pr['name']),
                          subtitle: Text(getSection(pr['section'])),
                          leading: Icon(Icons.description_outlined,
                              color: MAIN_GREEN),
                          onTap: () {
                            Get.to(SingleTopics(data: pr));
                          },
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
