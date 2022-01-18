import 'package:flutter/material.dart';

import 'Functions/getAPIData.dart';
import 'inc/common.dart';
import 'inc/strings.dart';

class Feeds extends StatefulWidget {
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  Map<String, Color> _clrs = {
    'Alert': Color(0xff3498db),
    'Information': Color(0xfff39c12),
    'Notice': Color(0xff8e44ad),
    'Warning': Color(0xffe74c3c),
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
        future: getFeeds(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading Feeds!"));
          } else {
            var d = snapshot.data;
            return Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                  color: _clrs[d['type']]!.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                          color: _clrs[d['type']],
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        d['type'],
                        style: TextStyle(color: Colors.white),
                      )),
                  br(5),
                  Text(
                    d['feed'],
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
