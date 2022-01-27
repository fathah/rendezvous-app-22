import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';

class AdCarosal extends StatelessWidget {
  const AdCarosal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List? utils = mainBox!.get('utils');
    String? adUrl;
    if (utils != null) {
      utils.forEach((element) {
        if (element['util_name'] == 'adImage') {
          adUrl = element['util_value'];
        }
      });
    }
    return Container(
      margin: EdgeInsets.only(
        left: 22,
        right: 22,
        top: 15,
        bottom: 10,
      ),
      height: 130,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: adUrl ?? "https://manzilmedia.net/apps/rendezvous/ad.jpg",
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
    );
  }
}
