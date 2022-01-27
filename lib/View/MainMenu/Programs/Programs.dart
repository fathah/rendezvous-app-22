import 'package:flutter/material.dart';
import 'package:rendezvous/View/MainMenu/Programs/SingleProgram.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

// ignore: must_be_immutable
class Programs extends StatelessWidget {
  Programs({Key? key}) : super(key: key);
  List programs = programBox!.get('programs') ?? [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
        centerTitle: true,
      ),
      body: programs.length < 0
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
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Colors.grey[400]),
                      leading: Icon(Icons.article, color: MAIN_GREEN),
                      onTap: () {
                        Get.to(SingleProgram(data: programs[index]));
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
