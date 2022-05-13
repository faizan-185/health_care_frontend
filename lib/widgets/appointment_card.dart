import 'package:flutter/material.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/models/appointment.dart';
import 'package:health_care/screens/appointments/accept_request.dart';

import '../config/styles.dart';

class AppointmentCard extends StatefulWidget {
  Appointment appointment;
  AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),

          width: screenSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 8,
                color: Colors.blueGrey.withOpacity(0.8),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Appointment Id:", style: listTilePrice,),
                  Text(widget.appointment.appointmentId, style: listTileTitle,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Appointment Status:", style: listTilePrice,),
                  Text(widget.appointment.status, style: listTileTitle,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Requested At:", style: listTilePrice,),
                  Text(widget.appointment.dateTime, style: listTileTitle,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Appointment At:", style: listTilePrice,),
                  Text(widget.appointment.appointmentDateTime == "" ? "Not Decided" : widget.appointment.appointmentDateTime.split('T').join(' At ').split('.')[0], style: listTileTitle,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Doctor Name:", style: listTilePrice,),
                  Text(widget.appointment.doctor.user.displayName, style: listTileTitle,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Doctor Email:", style: listTilePrice,),
                  Text(widget.appointment.doctor.user.email, style: listTileTitle,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Doctor Phone:", style: listTilePrice,),
                  Text(widget.appointment.doctor.user.phoneNumber, style: listTileTitle,)
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}


class DoctorAppointmentCard extends StatefulWidget {
  bool next;
  Appointment appointment;
  DoctorAppointmentCard({Key? key, required this.appointment, required this.next}) : super(key: key);

  @override
  State<DoctorAppointmentCard> createState() => _DoctorAppointmentCardState();
}

class _DoctorAppointmentCardState extends State<DoctorAppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.next)
        Navigator.push(context, new MaterialPageRoute(builder: (context) => AcceptRequest(appointment: widget.appointment)));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),

            width: screenSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 8,
                  color: Colors.blueGrey.withOpacity(0.8),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Appointment Id:", style: listTilePrice,),
                    Text(widget.appointment.appointmentId, style: listTileTitle,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Appointment Status:", style: listTilePrice,),
                    Text(widget.appointment.status, style: listTileTitle,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Requested At:", style: listTilePrice,),
                    Text(widget.appointment.dateTime, style: listTileTitle,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Appointment At:", style: listTilePrice,),
                    Text(widget.appointment.appointmentDateTime == "" ? "Not Decided" : widget.appointment.appointmentDateTime.split('T').join(' At ').split('.')[0], style: listTileTitle,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Patient Name:", style: listTilePrice,),
                    Text(widget.appointment.patient.user.displayName, style: listTileTitle,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Patient Email:", style: listTilePrice,),
                    Text(widget.appointment.patient.user.email, style: listTileTitle,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Patient Phone:", style: listTilePrice,),
                    Text(widget.appointment.patient.user.phoneNumber, style: listTileTitle,)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}

