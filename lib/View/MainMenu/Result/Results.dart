import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List programs = [];

  @override
  void initState() {
    super.initState();
    List prgms = programBox!.get('programs') ?? [];
    if (prgms.length > 0) {
      List tempPrs = [];
      prgms.forEach((singlePr) {
        if (singlePr['resultDeclared'] == "1") {
          tempPrs.add(singlePr);
        }
      });
      setState(() {
        programs = tempPrs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MAIN_GREEN,
        title: Text('Program Results'),
        centerTitle: true,
      ),
      body: programs.length < 0
          ? Center(child: Text("No Results Declared"))
          : ListView.builder(
              itemCount: programs.length,
              itemBuilder: (BuildContext context, int index) {
                var data = programs[index];
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
                    leading: Icon(
                      Icons.event_available_outlined,
                      color: MAIN_GREEN,
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${data['name']}"),
                        brw(5),
                        Text(
                          "(${getSection(data['section'])})",
                          style: TextStyle(
                            fontSize: 12,
                            color: MAIN_GREEN,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      resultModal(data);
                    },
                  ),
                );
              },
            ),
    );
  }

  resultModal(data) {
    var results = programBox!.get('programList');
    List finalResults = [];
    if (results != null) {
      results.forEach((singleResult) {
        if (singleResult['programid'] == data['id']) {
          finalResults.add(singleResult);
        }
      });
      finalResults.sort((a, b) {
        return int.parse(a['rank']) - int.parse(b['rank']);
      });
    }

    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    data['name'],
                    style: TextStyle(
                      fontSize: 20,
                      color: MAIN_GREEN,
                    ),
                  ),
                ),
                br(10),
                finalResults.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                title: Text(data['name']),
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
                                  width: 30,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: getThemeColor(data['groupId']),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${data['groupId'].toUpperCase()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              "Results not found. Please restart the app.",
                              style: TextStyle(color: MAIN_ORANGE)),
                        ),
                      )
              ],
            ),
          );
        });
  }
}
