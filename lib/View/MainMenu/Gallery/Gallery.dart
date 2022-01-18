import 'package:flutter/material.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/View/MainMenu/Gallery/ViewCategory.dart';
import 'package:rendezvous/inc/Constants.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  var cats = vrBox!.get('fileCategories');
  @override
  void initState() {
    getFilesFromAPI();
    getFilesCategoriesFromAPI().then((value) {
      setState(() {
        cats = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(cats);
    return Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
          centerTitle: true,
        ),
        body: Container(
          child: cats != null
              ? Container(
                  child: ListView.builder(
                    itemCount: cats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(ViewCategory(catName: cats[index]));
                          },
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          title: Text(cats[index]),
                          leading: Icon(
                            Icons.folder_rounded,
                            size: 50,
                            color: MAIN_GREEN,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ));
  }
}
