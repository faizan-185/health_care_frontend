import 'package:flutter/material.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/models/appointment.dart';

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
          height: 230,
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
                  Text("Appointment Date:", style: listTilePrice,),
                  Text(widget.appointment.appointmentDateTime == "" ? "Not Decided" : widget.appointment.appointmentDateTime, style: listTileTitle,)
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
