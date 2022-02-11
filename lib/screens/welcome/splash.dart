import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:health_care/config/styles.dart';
import 'dart:async';
import 'package:health_care/config/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  route() {
    Navigator.popAndPushNamed(context, "/LoginScreen");
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: DefaultTextStyle(
          style: bigHeadingTextStyle,
          child: AnimatedTextKit(
            pause: Duration(seconds: 2),
            isRepeatingAnimation: false,
            animatedTexts: [
              TyperAnimatedText('HealthCare'),
            ]
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
}
