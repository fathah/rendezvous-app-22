import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';

// ignore: must_be_immutable
class GeometryContainer extends StatelessWidget {
  double? height;
  Widget child;
  bool isOrange = false;
  GeometryContainer(
      {Key? key, this.height, required this.child, this.isOrange = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: [
      Container(
        width: Get.width,
        height: height ?? Get.height * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/geometry.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        width: Get.width,
        height: height ?? Get.height * 0.3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isOrange ? MAIN_ORANGE : MAIN_GREEN,
              isOrange
                  ? MAIN_ORANGE.withOpacity(0.8)
                  : MAIN_GREEN.withOpacity(0.8),
            ],
          ),
        ),
      ),
      Container(
        width: Get.width,
        height: height ?? Get.height * 0.3,
        child: child,
      ),
    ]));
  }
}
