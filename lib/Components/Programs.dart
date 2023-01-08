import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rendezvous/Functions/programs/get_name.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/models/db.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ParticipantPrograms extends StatelessWidget {
  ParticipantPrograms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: mainBox!.listenable(keys: [DBKeys.participations]),
        builder: (BuildContext context, Box box, Widget? child) {
          List partisList = box.get(DBKeys.participations) ?? [];
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
                  partisList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text("No Programs"),
                          ),
                        )
                      : MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: partisList.length,
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
                                          context, partisList[index]);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.api,
                                            color: MAIN_GREEN,
                                          ),
                                          title: Text(getProgramName(
                                              partisList[index]['programid'])),
                                          trailing: partisList[index]['rank'] !=
                                                  "0"
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
        });
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
                  getProgramName(data['programid']),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                br(5),
                data[3] != null
                    ? Text("Schedule:${data['schedule']}",
                        style: TextStyle(color: Colors.green))
                    : Text(
                        "Schedule Not Announced",
                        style: TextStyle(color: MAIN_ORANGE),
                      ),
                br(10),
                data['rank'] != "0"
                    ? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          Navigator.pop(context);
                          launchUrl(
                              Uri.parse(
                                  "https://glocal.markazgarden.org/rendezvous/certificate?id=${mainBox!.get("cardNo")}&programId=${data[0]}&rank=${data[2]}&prName=${data[1]}"),
                              mode: LaunchMode.externalApplication);
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
