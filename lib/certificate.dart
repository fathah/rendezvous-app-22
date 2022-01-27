import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:rendezvous/inc/strings.dart';
import 'inc/common.dart';

// ignore: must_be_immutable
class Certificate extends StatefulWidget {
  String? comp;
  int? rank;
  Certificate({this.comp, this.rank});
  @override
  _CertificateState createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  String? team = getTeam();
  File? cert;
  img.Image? image;
  img.BitmapFont? myFont;

  Directory? dir;
  File? imageFinal;

  @override
  void initState() {
    getApplicationDocumentsDirectory().then((direc) async {
      setState(() {
        dir = direc;
        cert = File(direc.path + "/certificate.jpg");
      });
    });

    super.initState();
  }

  editImage(Directory direc) {
    image = img.decodeJpg(cert!.readAsBytesSync());
    img.drawString(image!, img.arial_14, 20, 30, 'Hello World',
        color: 0xff000000);
    File(direc.path + '/${widget.comp}.jpg')
        .writeAsBytesSync(img.encodeJpg(image!));

    setState(() {
      dir = direc;
      imageFinal = File(direc.path + '/${widget.comp}.jpg');
    });
  }

  imageSetup() {
    getApplicationDocumentsDirectory().then((direc) async {
      setState(() {
        cert = File(direc.path + "/certificate.jpg");
        image = img.decodeJpg(cert!.readAsBytesSync());
      });
      image = img.decodeJpg(cert!.readAsBytesSync());
      img.drawString(image!, img.arial_14, 0, 0, 'Hello World');

      setState(() {
        dir = direc;
        imageFinal = File(direc.path + '/${widget.comp}.jpg');
      });
      File(direc.path + '/${widget.comp}.jpg')
          .writeAsBytesSync(img.encodeJpg(image!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          br(10),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: getThemeColor(team).withOpacity(0.2),
                child: Text(
                  "${widget.rank}",
                  style: TextStyle(
                      color: getThemeColor(team),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.comp ?? "",
                style: TextStyle(fontSize: 20, color: getThemeColor(team)),
              ),
            ],
          ),
          br(20),
          TextButton(
              onPressed: () {
                editImage(dir!);
              },
              child: Text("Image")),
          Image.file(File(dir!.path + '/${widget.comp}.jpg'))
        ],
      ),
    );
  }
}
