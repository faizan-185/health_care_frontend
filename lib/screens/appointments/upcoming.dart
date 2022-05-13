import 'package:flutter/material.dart';
import 'package:health_care/models/appointment.dart';

import '../../config/styles.dart';
import '../../widgets/appbar.dart';
import '../../widgets/appointment_card.dart';
import '../../widgets/doctor_drawer.dart';

class UpcomingAppointments extends StatefulWidget {
  List<Appointment> appointments;
  UpcomingAppointments({Key? key, required this.appointments}) : super(key: key);

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text("Upcoming Appointments", style: secondaryBigHeadingTextStyle);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: SecondDrawer(),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: [
          _header(),
          SizedBox(height: 20,),
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemCount: widget.appointments.length,
            itemBuilder: (BuildContext context, int index){
              return DoctorAppointmentCard(appointment: widget.appointments[index], next: false,);
            },
          )
        ],
      ),
    );
  }
}
