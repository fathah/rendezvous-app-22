import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'inc/strings.dart';

class WebPage extends StatefulWidget {
  String? link;
  String? title;
  WebPage({@required this.link, @required this.title});
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  int connectionStatus = 1;
  Future<int> check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return 2;
      }
      return 0;
    } on SocketException catch (_) {
      return 3;
    }
  }

  @override
  void initState() {
    check().then((value) {
      if (value == 2) {
        setState(() {
          connectionStatus = 2;
        });
      } else {
        setState(() {
          connectionStatus = 3;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        centerTitle: true,
      ),
      body: connectionStatus == 1
          ? Container(
              child: Center(
                child: SpinKitThreeBounce(
                  color: mainColor,
                  size: 30,
                ),
              ),
            )
          : connectionStatus == 2
              ? WebView(
                  initialUrl: widget.link,
                  javascriptMode: JavascriptMode.unrestricted,
                )
              : Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/images/error.svg",
                        height: 150,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Please check your connection!",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )),
                ),
    );
  }
}
