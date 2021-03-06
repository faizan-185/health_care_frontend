import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/light_color.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/text_styles.dart';
import 'package:health_care/config/themes.dart';
import 'package:health_care/models/appointment.dart';
import 'package:health_care/services/api_funtions/appointment_requests.dart';
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/services/functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/appointment_card.dart';
import 'package:health_care/widgets/category-card.dart';
import 'package:health_care/widgets/drawer.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key}) : super(key: key);

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {

  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text("My Appointments", style: secondaryBigHeadingTextStyle);
  }
  late List<Appointment> appointments = [];
  List<Appointment> pending = [];
  List<Appointment> rejected = [];
  List<Appointment> accepted = [];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void get_appointments() async{
    setState(() {
      status = true;
    });
    all_appointments().then((value) {
      var data = jsonDecode(value.body)['appointment'] as List;
      appointments = data.map((appointment) => Appointment.fromJson(appointment)).toList();
      var user_appointments = [];
      appointments.forEach((element) {
        if(element.patient.user.userId == UserLoginData.userId)
          {
            user_appointments.add(element);
          }
      });
      appointments.clear();
      user_appointments.forEach((element) {
        if (element.status == "pending")
          pending.add(element);
        else if (element.status == "rejected")
          rejected.add(element);
        else
          accepted.add(element);
      });

      setState(() {
        status = false;
      });
    });

  }

  @override
  void initState() {
    super.initState();
    get_appointments();
  }

  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackground,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: status ? Center(child: CircularProgressIndicator(color: kPrimary,)) : ListView(
        padding: EdgeInsets.only(left: 16, right: 16),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 20,),
          _header(),
          SizedBox(height: 10,),
        <Widget>[
          pending.length==0 ? Text("No Pending Appointments!", style: TextStyle(color: Colors.red),) : ListView.builder(
            reverse: true,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: pending.length,
              itemBuilder: (BuildContext context, int index) {
            return AppointmentCard(appointment: pending[index],);
          }),
          rejected.length==0 ? Text("No Rejected Appointments!", style: TextStyle(color: Colors.red),) : ListView.builder(
              scrollDirection: Axis.vertical,
              reverse: true,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: rejected.length,
              itemBuilder: (BuildContext context, int index) {
                return AppointmentCard(appointment: rejected[index],);
              }),
          accepted.length==0 ? Text("No Accepted Appointments!", style: TextStyle(color: Colors.red),) : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              reverse: true,
              physics: ScrollPhysics(),
              itemCount: accepted.length,
              itemBuilder: (BuildContext context, int index) {
                return AppointmentCard(appointment: accepted[index],);
              }),
        ].elementAt(_selectedIndex),
          SizedBox(height: 30,)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.exclamation),
            label: 'Pending',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Rejected',
            backgroundColor: kPrimary,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.check),
            label: 'Accepted',
            backgroundColor: kPrimary,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimary,
        onTap: _onItemTapped,
      ),
    );
  }
}
