import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/View/MainMenu/Watch/YoutubePlayer.dart';
import 'package:rendezvous/api/watch_videos.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/models/db.dart';

class Watch extends StatelessWidget {
  Watch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getWatchVideos();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: mainBox!.listenable(keys: [DBKeys.watch]),
        builder: (BuildContext context, Box box, Widget? child) {
          List data = box.get(DBKeys.watch) ?? [];
          return data.isEmpty
              ? Center(
                  child: Text("Nothing Found. But we're getting here soon."),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    String youtubeId = data[index]['link']
                        .split('=')[1]
                        .replaceAll('&ab_channel', '');

                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            playSheet(youtubeId, data[index]['title']);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 110,
                                width: Get.width * 0.4,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://img.youtube.com/vi/$youtubeId/0.jpg",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15, right: 15),
                                      child: Text(data[index]['title'],
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      color: MAIN_GREEN.withOpacity(0.2),
                                      child: Text(
                                        data[index]['category'],
                                        style: TextStyle(
                                            color: MAIN_GREEN, fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  playSheet(ytId, title) {
    return showModalBottomSheet(
        context: Get.context!,
        builder: (ctx) {
          return Container(
              child: YoutubePlay(
            ytId: ytId,
            title: title,
          ));
        });
  }
}
