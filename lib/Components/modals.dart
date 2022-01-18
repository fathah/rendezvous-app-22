import 'package:flutter/material.dart';
import 'package:rendezvous/inc/Constants.dart';

showInfoModal(context, header, body) {
  return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                header,
                style: TextStyle(fontSize: 18, color: MAIN_GREEN),
              ),
              br(5),
              Text(body),
              br(20)
            ],
          ),
        );
      });
}
