import 'package:flutter/material.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ParticipantPrograms extends StatefulWidget {
  ParticipantPrograms({Key? key}) : super(key: key);

  @override
  _ParticipantProgramsState createState() => _ParticipantProgramsState();
}

class _ParticipantProgramsState extends State<ParticipantPrograms> {
  List programs = [];

  @override
  void initState() {
    super.initState();
    if (mainBox!.get("programList") == null) {
      print("no programs");
      getProgramsFromAPI().then((value) {
        setState(() {
          programs = mainBox!.get("programList");
        });
      });
    } else {
      setState(() {
        programs = mainBox!.get("programList");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(programs);
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
            programs.length < 1
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("No Programs"),
                    ),
                  )
                : programs.length < 1
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
                          itemCount: programs.length,
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
                                        context, programs[index]);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.api,
                                          color: MAIN_GREEN,
                                        ),
                                        title: Text("${programs[index][1]}"),
                                        trailing: programs[index][2] != "0"
                                            ? Icon(
                                                Icons.emoji_events_outlined,
                                                color: Colors.green,
                                              )
                                            : br(0),
                                      )),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ));
  }

  singleProgramModal(context, data) {
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
                  data[1],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                br(5),
                data[3] != null
                    ? Text("Schedule:${data[3]}",
                        style: TextStyle(color: Colors.green))
                    : Text(
                        "Schedule Not Announced",
                        style: TextStyle(color: MAIN_ORANGE),
                      ),
                br(10),
                data[2] != "0"
                    ? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          Navigator.pop(context);
                          launch(
                              "https://glocalmedia.tech/rendezvous/certificate?id=${mainBox!.get("cardNo")}&programId=${data[0]}&rank=${data[2]}&prName=${data[1]}");
                        },
                        child: Text('Download Certificate'))
                    : br(0),
                br(40),
              ],
            ),
          );
        });
  }
}
