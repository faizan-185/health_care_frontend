import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/config/light_color.dart';
import 'package:health_care/config/styles.dart';

String addCommas(String number) {
  RegExp _regExp = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  // Function _mathFunc = (Match match) => '${match[1]},';
  String _result =
      number.replaceAllMapped(_regExp, (Match match) => '${match[1]},');
  return _result;
}

String getFirstName({required String fullName}) {
  var names = fullName.split(' ');
  // int namesCount = names.length;
  String firstName = names[0];
  // String lastName = names[namesCount - 1];
  return firstName;
}

String getLastName({required String fullName}) {
  var names = fullName.split(' ');
  int namesCount = names.length;
  // String firstName = names[0];
  String lastName = names[namesCount - 1];
  return lastName;
}

String getFirstNameAndLastInitial({required String fullName}) {
  var names = fullName.split(' ');
  int namesCount = names.length;
  String firstName = names[0];
  String lastName = names[namesCount - 1];
  return "$firstName ${lastName[0]}.".inTitleCase;
}

String getInitials(String string, [int limitTo = 2]) {
  if (string.isEmpty) {
    return '';
  }

  var buffer = StringBuffer();
  var split = string.split(' ');

  //For one word
  if (split.length == 1) {
    return string.substring(0, 1).toUpperCase();
  }

  for (var i = 0; i < (limitTo); i++) {
    buffer.write(split[i][0]);
  }

  return buffer.toString().toUpperCase();
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get inTitleCase => this.split(" ").map((str) => str.inCaps).join(" ");
}

final helloWorld = 'hello world'.inCaps; // 'Hello world'
final helloWorld1 = 'hello world'.allInCaps; // 'HELLO WORLD'
final helloWorld2 = 'hello world'.inTitleCase; // 'Hello World'

String getPhoneNumber(String number) {
  String temp;
  if (number.trim().length > 10 && number.startsWith('0')) {
    temp = '+234' + number.trim().substring(1);
    print(temp);
    return temp;
  } else if (number.trim().length > 10 && number.startsWith('+')) {
    temp = number.trim();
    print(temp);
    return temp;
  } else if (number.trim().length > 10 &&
      !number.startsWith('+') &&
      !number.startsWith('0')) {
    temp = '+' + number.trim();
    print(temp);
    return temp;
  } else
    return number.trim();
}

Future<void> copyToClipboard(
    {required String copyText, required BuildContext context}) async {
  await Clipboard.setData(ClipboardData(text: copyText));
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: kGeneralWhite,
    padding: EdgeInsets.symmetric(horizontal: 30),
    elevation: 4,
    content: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kGeneralWhite,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            spreadRadius: 2.0,
            blurRadius: 8.0,
            offset: Offset(2, 4),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Copied to clipboard',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            color: kPrimary, fontWeight: FontWeight.w600),
      ),
    ),
  ));
}

Color randomColor() {
  var random = Random();
  final colorList = [
    kPrimary,
    LightColor.orange,
    LightColor.green,
    LightColor.grey,
    LightColor.lightOrange,
    LightColor.skyBlue,
    LightColor.titleTextColor,
    Colors.red,
    Colors.brown,
    LightColor.purpleExtraLight,
    LightColor.skyBlue,
  ];
  var color = colorList[random.nextInt(colorList.length)];
  return color;
}
