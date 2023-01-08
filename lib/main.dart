import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rendezvous/certificate.dart';
import 'package:rendezvous/inc/strings.dart';
import 'package:rendezvous/results.dart';
import 'Functions/getAPIData.dart';
import 'chart.dart';
import 'feeds.dart';
import 'inc/Constants.dart';
import 'inc/common.dart';
import 'splash.dart';

void main() async {
  await Hive.initFlutter();
  mainBox = await Hive.openBox('mainBox');
  programBox = await Hive.openBox('programBox');
  numKeyBox = await Hive.openBox('numKeyBox');
  vrBox = await Hive.openBox('vrBox');
    studentsBox = await Hive.openBox('studentsBox');

  participationBox = await Hive.openBox('participationBox');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rendezvous',
      defaultTransition: Transition.fadeIn,
      theme: ThemeData(
          primarySwatch: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: mainFont,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: primaryColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

// ignore: must_be_immutable
class HomeOld extends StatefulWidget {
  String? chest;
  HomeOld({this.chest});

  @override
  _HomeOldState createState() => _HomeOldState();
}

class _HomeOldState extends State<HomeOld> {
  String? chestID;
  Directory? dir;
  File? stdFile;
  String? team = getTeam();

  var data;

  @override
  void initState() {
    if (widget.chest == null) {
      getChest().then((value) {
        setState(() {
          chestID = value;
        });
      });
    } else {
      setState(() {
        chestID = widget.chest!.split('/')[1];
      });
    }

    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      setState(() {
        stdFile = File(dir!.path + "/" + "students.json");
      });
    });
    // downloadCertificate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getThemeColor(team),
        title: Text("Rendezvous"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logout(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getJSON(stdFile!),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: size.height,
                width: size.width,
                child: SpinKitChasingDots(
                  color: getThemeColor(team),
                  size: 30,
                ),
              );
            } else {
              var dat = snapshot.data;
              var snDat;
              if (dat != null) {
//  for (var i in dat) {
//                 if (i['chest'] == chestID) {
//                   snDat = i;
//                 }
//               }
              }

              var team = snDat['team'];
              saveTeam(team);
              //dat.where((std) => std['id'] == chestID).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  br(5),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: getThemeColor(team),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snDat['name'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Text(
                                  chestID ?? "",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              ],
                            ),
                            if (snDat['indPoint'] != null &&
                                snDat['indPoint'] != 0)
                              Container(
                                  padding: EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    children: [
                                      Text("Point"),
                                      Text(
                                        "${snDat['indPoint']}",
                                        style: TextStyle(
                                            color: getThemeColor(team),
                                            fontSize: 20),
                                      ),
                                    ],
                                  ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_note,
                          color: getThemeColor(team),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Programs:",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  snDat['programList'].length < 1
                      ? Center(child: Text('No Programs'))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snDat['programList'].length,
                            itemBuilder: (BuildContext context, int index) {
                              var d = snDat['programList'][index];
                              int rank = int.parse(d[1]);
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12,
                                              width: 0.5))),
                                  child: ListTile(
                                    title: Text(d[0]),
                                    leading: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: getThemeColor(team),
                                    ),
                                    trailing: rank > 0 && rank < 4
                                        ? Icon(Icons.emoji_events_outlined,
                                            color: Colors.green)
                                        : SizedBox(
                                            width: 0,
                                          ),
                                    onTap: () {},
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
//Feeds
                  br(20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.rss_feed_outlined,
                          color: getThemeColor(team),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Feeds:",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Feeds(),
                  br(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timeline,
                          color: getThemeColor(team),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Group Score:",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  br(20),
                  Center(child: TeamChart()),
                  br(35)
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: getThemeColor(team),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return WebPage(
                  link: "https://markazgarden.org/rendezvous/results/",
                  title: "Results");
            },
          ));
        },
        label: Text("Results"),
        icon: Icon(Icons.analytics_outlined),
      ),
    );
  }

  certifBottom(comp, rank) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Certificate(
          comp: comp,
          rank: rank,
        );
      },
    );
  }
}

// Expanded(
//                 child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//               decoration: BoxDecoration(
//                 color: getThemeColor(team),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.campaign_outlined,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Shout Out',
//                         style: TextStyle(color: Colors.white),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ))
