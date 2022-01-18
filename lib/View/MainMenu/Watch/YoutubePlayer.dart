import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class YoutubePlay extends StatelessWidget {
  String ytId;
  String title;
  YoutubePlay({Key? key, required this.ytId, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: ytId,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: true,
              ),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: MAIN_ORANGE,
            progressColors: ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: MAIN_ORANGE,
            ),
            bottomActions: [
              CurrentPosition(),
              SizedBox(width: 10),
              ProgressBar(
                isExpanded: true,
              ),
              SizedBox(width: 10),
              RemainingDuration(),
              PlaybackSpeedButton()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Text(
                        'Close',
                        style: TextStyle(color: MAIN_ORANGE),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              br(10),
              ElevatedButton(
                  onPressed: () async {
                    if (!await launch("https://www.youtube.com/watch?v=$ytId"))
                      throw 'Could not launch Youube';
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Open in Youtube"),
                  )),
              br(50)
            ],
          ),
        )
      ],
    );
  }
}
