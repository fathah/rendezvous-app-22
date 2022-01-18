import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rendezvous/inc/Constants.dart';

// ignore: must_be_immutable
class ViewCategory extends StatefulWidget {
  String catName;
  ViewCategory({Key? key, required this.catName}) : super(key: key);

  @override
  _ViewCategoryState createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  List data = [];
  @override
  void initState() {
    var files = vrBox!.get('files');
    List tempFiles = [];
    files.forEach((e) {
      if (e['file_category'] == widget.catName && e['file_type'] == "gallery") {
        tempFiles.add(e);
      }
    });
    setState(() {
      data = tempFiles;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catName),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          String imgLink = "https://drive.google.com/uc?export=view&id=" +
              data[index]['file_link'].split('/')[5];
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                viewImage(imgLink);
              },
              child: CachedNetworkImage(
                imageUrl: imgLink,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  viewImage(imgLink) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  child: CachedNetworkImage(
                    imageUrl: imgLink,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                br(10),
                ElevatedButton(
                    onPressed: () {
                      var dio = Dio();
                      getExternalStorageDirectory().then((value) async {
                        await dio.download(imgLink, value!.path);
                      });
                    },
                    child: Text("Download")),
                br(20),
              ],
            ),
          );
        });
  }
}
