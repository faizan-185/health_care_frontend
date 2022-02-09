import 'package:flutter/material.dart';
import 'package:health_care/config/light_color.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/styles.dart';

AppBar appBarWidget(var context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).backgroundColor,
    leading: Icon(
      Icons.short_text,
      size: 30,
      color: kPrimary,
    ),
    actions: <Widget>[
      Icon(
        Icons.notifications_none,
        size: 30,
        color: kPrimary,
      ),
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Image.asset("assets/user.png", fit: BoxFit.fill),
        ),
      ).p(8),
    ],
  );
}