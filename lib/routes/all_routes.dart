import 'package:flutter/material.dart';
import 'package:health_care/routes/route.dart';
import 'package:health_care/screens/auth/login.dart';
import 'package:health_care/screens/auth/otp.dart';
import 'package:health_care/screens/auth/register.dart';
import 'package:health_care/screens/auth/reset_password.dart';
import 'package:health_care/screens/home/home_screen.dart';
import 'package:health_care/screens/welcome/splash.dart';
import 'package:health_care/screens/welcome/welcome_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => SplashScreen(),
      '/HomeScreen': (_) => HomeScreen(),
      '/ResetPasswordScreen': (_) => ResetPasswordScreen(),
      '/OptScreen': (_) => OtpVerification(),
      '/RegisterScreen': (_) => RegisterScreen(),
      '/LoginScreen': (_) => LoginScreen()
    };
  }

  static CustomRoute<bool>? onGenerateRoute(RouteSettings settings) {
    final List<String>? pathElements = settings.name?.split('/');
    if (pathElements![0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "ResetPasswordScreen":
    return CustomRoute(builder: (BuildContext context)=> ResetPasswordScreen());
      case "OtpScreen":
        return CustomRoute(builder: (BuildContext context)=> OtpVerification());
      case "RegisterScreen":
        return CustomRoute(builder: (BuildContext context)=> RegisterScreen());
      case "LoginScreen":
        return CustomRoute(builder: (BuildContext context)=> LoginScreen());
      case "HomeScreen":
        return CustomRoute<bool>(
            builder: (BuildContext context) => HomeScreen());
    }
  }
}

