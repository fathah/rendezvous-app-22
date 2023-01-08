import 'package:flutter/material.dart';
import 'package:rendezvous/Functions/programs/get_name.dart';
import 'package:rendezvous/Functions/students/get_name.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

class Results extends StatelessWidget {
  Results({Key? key}) : super(key: key);
  List programs = programBox!.values.toList();

  @override
  Widget build(BuildContext context) {
    programs.sort((a, b) {
      return int.parse(a['id']).compareTo(int.parse(b['id']));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        backgroundColor: MAIN_GREEN,
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
                        resultModal(programs[index]);
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}

resultModal(Map program) {
  List partis = participationBox!.values
      .where((el) => el['programid'] == program['id'])
      .toList();
  List finalResults = [];

  bool sResultDeclared =
      program['resultDeclared'] == 1 || program['resultDeclared'] == "1";
  print(program);
  if (sResultDeclared && partis.isNotEmpty) {
    print("Declared");
    partis.forEach((prs) {
      if (int.parse("${prs['rank']}") != 0) {
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
        finalResults.add(prs);
      }
    });
    finalResults.sort((a, b) {
      return int.parse(a['rank']) - int.parse(b['rank']);
    });
  }
  print(finalResults);
  return showModalBottomSheet(
      context: Get.context!,
      builder: (ctx) {
        return Container(
          color: MAIN_GREEN.withOpacity(0.1),
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        program['name'],
                        style: TextStyle(
                          fontSize: 20,
                          color: MAIN_GREEN,
                        ),
                      ),
                      Text(
                        getSection(program['section']),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )),
              br(10),
              sResultDeclared && finalResults.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: Get.height * 0.4,
                      child: ListView.builder(
                        itemCount: finalResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = finalResults[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.2,
                                ),
                              ),
                            ),
                            child: ListTile(
                              title:
                                  Text("${getStudentName(data['studentid'])}"),
                              leading: CircleAvatar(
                                backgroundColor: Colors.green[700],
                                child: Text(
                                  '${data['rank']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              trailing: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  color: getThemeColor(data['campusId']),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(
                                        '${data['campusId']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                            "Results not declared yet. Please check back later.",
                            style: TextStyle(color: MAIN_ORANGE)),
                      ),
                    )
            ],
          ),
        );
      });
}
