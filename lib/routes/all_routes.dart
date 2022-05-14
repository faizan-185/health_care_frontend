import 'package:flutter/material.dart';
import 'package:health_care/screens/appointments/accept_request.dart';
import 'package:health_care/screens/appointments/conference_call.dart';
import 'package:health_care/screens/appointments/my_appointments.dart';
import 'package:health_care/screens/appointments/pending.dart';
import 'package:health_care/screens/auth/profile.dart';
import 'package:health_care/screens/home/second_home_screen.dart';
import 'package:health_care/screens/hospital/all_hospitals_screen.dart';
import 'package:health_care/routes/route.dart';
import 'package:health_care/screens/auth/login.dart';
import 'package:health_care/screens/auth/otp.dart';
import 'package:health_care/screens/auth/register.dart';
import 'package:health_care/screens/auth/reset_password.dart';
import 'package:health_care/screens/auth/send_email.dart';
import 'package:health_care/screens/home/home_screen.dart';
import 'package:health_care/screens/pharmacy/all_pharmacies.dart';
import 'package:health_care/screens/pharmacy/my_orders.dart';
import 'package:health_care/screens/pharmacy/pharmacy_details.dart';
import 'package:health_care/screens/welcome/splash.dart';

import '../screens/appointments/dr_appointments.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => SplashScreen(),
      '/HomeScreen': (_) => HomeScreen(),
      '/ResetPasswordScreen': (_) => ResetPasswordScreen(),
      '/OtpScreen': (_) => OtpVerification(),
      '/RegisterScreen': (_) => RegisterScreen(),
      '/LoginScreen': (_) => LoginScreen(),
      '/SendEmail': (_) => SendEmail(),
      '/AllHospitalsScreen': (_) => AllHospitalsScreen(),
      '/ProfileScreen': (_) => Profile(),
      '/MyAppointments': (_) => MyAppointments(),
      '/AllPharmacies': (_) => AllPharmacies(),
      '/MyOrders': (_) => MyOrders(),
      '/DoctorHomeScreen': (_) => DoctorHomeScreen(),
      '/PendingAppointments': (_) => Pending(),
      '/DrAppointments': (_) => DrAppointments(),
      '/Meet': (_) => VideoCall()
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
      case "AllHospitalsScreen":
        return CustomRoute(builder: (BuildContext context)=> AllHospitalsScreen());
      case "ProfileScreen":
        return CustomRoute(builder: (BuildContext context)=> Profile());
      case "MyAppointments":
        return CustomRoute(builder: (BuildContext context)=> MyAppointments());
      case "AllPharmacies":
        return CustomRoute(builder: (BuildContext context)=> AllPharmacies());
    }
  }
}

