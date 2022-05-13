import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/models/appointment.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/appointment_card.dart';
import 'package:health_care/widgets/doctor_drawer.dart';

import '../../config/styles.dart';
import '../../services/api_funtions/appointment_requests.dart';
import '../../widgets/snackbars.dart';

class Pending extends StatefulWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  bool status = false;
  List<Appointment> appointments = [];
  List<Appointment> pending_appointments = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text("Pending Appointments", style: secondaryBigHeadingTextStyle);
  }

  void getPendingAppointments() async
  {
    setState(() {
      status = true;
    });
    await all_appointments_of_dr().then((value) {
      setState(() {
        status = false;
      });
      if(value.statusCode == 200)
        {
          var data = jsonDecode(value.body)['appointment'] as List;
          appointments = data.map((e) => Appointment.fromJson(e)).toList();
          appointments.forEach((element) {
            if(element.status == "pending")
              pending_appointments.add(element);
          });

        }
      else
        {
          ScaffoldMessenger.of(context).showSnackBar(snackBarError("An Error Occurred"));
        }
    });
  }


  @override
  void initState() {
    super.initState();
    getPendingAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: SecondDrawer(),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: [
          _header(),
          SizedBox(height: 5,),
          Text("Select an appointment for further process.", style: style13500,),
          SizedBox(height: 20,),
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemCount: pending_appointments.length,
            itemBuilder: (BuildContext context, int index){
              return DoctorAppointmentCard(appointment: pending_appointments[index], next: true,);
            },
          )
        ],
      ),
    );
  }
}
