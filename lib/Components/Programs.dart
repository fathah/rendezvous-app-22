import 'package:flutter/material.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/inc/Constants.dart';

class ParticipantPrograms extends StatelessWidget {
  ParticipantPrograms({Key? key}) : super(key: key);
  List? programs = mainBox!.get("programList");
  @override
  Widget build(BuildContext context) {
    if (programs == null) {
      print("no programs");
      getProgramsFromAPI().then((value) {
        programs = mainBox!.get("programList");
      });
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Program List",
              style: TextStyle(color: MAIN_ORANGE, fontSize: 18),
            ),
            br(10),
            programs == null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("Loading Programs"),
                    ),
                  )
                : programs!.length < 1
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text("No Programs"),
                        ),
                      )
                    : programs!.length < 1
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text("No Programs Found"),
                            ),
                          )
                        : MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: programs!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(bottom: 4),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(6),
                                      onTap: () {
                                        singleProgramModal(
                                            context, programs![index][0]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 15),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.api,
                                              color: MAIN_GREEN,
                                            ),
                                            brw(7),
                                            Text(programs![index][0]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
          ],
        ));
  }

  singleProgramModal(context, title) {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                br(5),
                Text(
                  "Time Schedule Not Announced",
                  style: TextStyle(color: MAIN_ORANGE),
                )
              ],
            ),
          );
        });
  }
}
