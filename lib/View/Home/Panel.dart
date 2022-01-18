import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

class Panel extends StatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  List menu = [
    {
      'title': 'Logout',
      'icon': Icons.logout_outlined,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MAIN_GREEN,
        title: const Text('Panel'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(menu[index]['title']),
            leading: Icon(menu[index]['icon']),
            onTap: () {
              if (menu[index]['title'] == 'Logout') {
                logout(context);
              }
            },
          );
        },
      ),
    );
  }
}
