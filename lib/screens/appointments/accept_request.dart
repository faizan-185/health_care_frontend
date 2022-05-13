import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/models/appointment.dart';
import 'package:health_care/services/api_funtions/appointment_requests.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/appointment_card.dart';
import 'package:health_care/widgets/doctor_drawer.dart';
import 'package:health_care/widgets/verido-primary-button.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/styles.dart';
import '../../logs/Log.dart';
import '../../logs/db_helper.dart';
import '../../widgets/snackbars.dart';

class AcceptRequest extends StatefulWidget {
  Appointment appointment;
  AcceptRequest({Key? key, required this.appointment}) : super(key: key);

  @override
  State<AcceptRequest> createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
  late String _setTime, _setDate;
  late String _hour, _minute, _time;
  late String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text("Appointment # ${widget.appointment.appointmentId}", style: secondaryBigHeadingTextStyle);
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dateTime = DateTime.parse("${selectedDate.year}-${selectedDate.month <= 9 ? "0" + selectedDate.month.toString() : selectedDate.month}-${selectedDate.day <= 9 ? "0" + selectedDate.day.toString() : selectedDate.day} ${selectedTime.hour <= 9 ? "0" + selectedTime.hour.toString() : selectedTime.hour}:${selectedTime.minute <= 9 ? "0" + selectedTime.minute.toString() : selectedTime.minute}:00").toString();
        print(dateTime);
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        dateTime = DateTime.parse("${selectedDate.year}-${selectedDate.month <= 9 ? "0" + selectedDate.month.toString() : selectedDate.month}-${selectedDate.day <= 9 ? "0" + selectedDate.day.toString() : selectedDate.day} ${selectedTime.hour <= 9 ? "0" + selectedTime.hour.toString() : selectedTime.hour}:${selectedTime.minute <= 9 ? "0" + selectedTime.minute.toString() : selectedTime.minute}:00").toString();
        print(dateTime);
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
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
          SizedBox(height: 20,),
          DoctorAppointmentCard(appointment: widget.appointment, next: false,),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Choose Date For Appointment',
                      style: listTileTitle,
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextFormField(
                          style: TextStyle(fontSize: 40),
                          textAlign: TextAlign.center,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _dateController,
                          onSaved: (String? val) {
                            _setDate = val!;
                          },
                          decoration: InputDecoration(
                              disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.only(top: 0.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  children: <Widget>[
                    Text(
                      'Choose Time  For Appointment',
                      style: listTileTitle,
                    ),
                    InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextFormField(
                          style: TextStyle(fontSize: 40),
                          textAlign: TextAlign.center,
                          onSaved: (String? val) {
                            _setTime = val!;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController,
                          decoration: InputDecoration(
                              disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.all(5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          SizedBox(width: screenSize.width,
            child: VeridoPrimaryButton(
              title: Text("Accept Request", style: kPrimaryButtonTextStyle,),
              isActive: true,
              onPressed: ()async{
                setState(() {
                  status = true;
                });
                await accept_request(dateTime, widget.appointment.appointmentId)
                .then((value) {
                  setState(() {
                    status = false;
                  });
                  print(value.body);
                  var data = jsonDecode(value.body);
                  if(value.statusCode == 200)
                    {
                      var handler = DatabaseHandler();
                      handler.initializeDB().whenComplete(() async {
                        DrLog l = new DrLog(
                            name: widget.appointment.patient.user.displayName,
                            datetime: DateTime.now().toString(),
                            type: "accept");
                        await handler.insertDrLog(l);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess(data['message']));
                      Navigator.pushNamed(context, '/PendingAppointments');
                    }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(snackBarError(data['message']));
                  }
                });
              },
            ),
          ),
          SizedBox(height: 50,),
          SizedBox(width: screenSize.width,
            child: VeridoRedButton(
              title: Text("Reject Request", style: kPrimaryButtonTextStyle,),
              isActive: true,
              onPressed: ()async{
                setState(() {
                  status = true;
                });
                await reject_request(widget.appointment.appointmentId)
                    .then((value) {
                  setState(() {
                    status = false;
                  });
                  print(value.body);
                  var data = jsonDecode(value.body);
                  if(value.statusCode == 200)
                  {
                    var handler = DatabaseHandler();
                    handler.initializeDB().whenComplete(() async {
                      DrLog l = new DrLog(
                          name: widget.appointment.patient.user.displayName,
                          datetime: DateTime.now().toString(),
                          type: "reject");
                      await handler.insertDrLog(l);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess(data['message']));
                    Navigator.pushNamed(context, '/PendingAppointments');
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(snackBarError(data['message']));
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
