import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rendezvous/api/notifications_get.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';
import 'package:rendezvous/models/db.dart';

class Notifications extends StatelessWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      getNotifications();
      var status = await Permission.notification.status;
      if (status.isDenied) {
        await Permission.notification.request();
      }
    });
    List notifs = mainBox!.get(DBKeys.notifications) ?? [];
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
                        title: Text(notifs[index]['title']),
                        subtitle: Text(notifs[index]['body']),
                        leading: Icon(getNotifIcon(notifs[index]['notifType']),
                            color: getNotifColor(notifs[index]['notifType'])),
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
