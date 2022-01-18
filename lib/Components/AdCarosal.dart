import 'package:flutter/material.dart';

class AdCarosal extends StatelessWidget {
  const AdCarosal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 22,
        right: 22,
        top: 30,
        bottom: 10,
      ),
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/images/ad.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
