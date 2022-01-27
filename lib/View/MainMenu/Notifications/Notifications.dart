import 'package:flutter/material.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List notifs = [];
  @override
  void initState() {
    if (mainBox!.get('feeds') != null) {
      setState(() {
        notifs = mainBox!.get('feeds').reversed.toList();
      });
    }
    getFeeds().then((value) {
      setState(() => notifs = value.reversed.toList());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: notifs.length > 0
          ? ListView.builder(
              itemCount: notifs.length,
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.15,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(notifs[index]['feed_body']),
                        leading: Icon(getNotifIcon(notifs[index]['feed_type']),
                            color: getNotifColor(notifs[index]['feed_type'])),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text('No Notifications'),
            ),
    );
  }
}
