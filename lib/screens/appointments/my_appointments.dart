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
import 'package:health_care/services/api_funtions/appointment_requests.dart';
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/services/functions.dart';
import 'package:health_care/widgets/appbar.dart';
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
    return Text("All Appointments", style: secondaryBigHeadingTextStyle).p16;
  }
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
      print(value.body);
      setState(() {
        status = false;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackground,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: status ? Center(child: CircularProgressIndicator(color: kPrimary,)) : ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          SizedBox(height: 10,),
        <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            height: screenSize.height,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Text("hi")
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            height: screenSize.height,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Text("hello")
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            height: screenSize.height,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Text("kesa")
              ],
            ),
          ),
        ].elementAt(_selectedIndex),
          SizedBox(height: 30,)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bell),
            label: 'Upcoming',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Rejected',
            backgroundColor: kPrimary,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.check),
            label: 'Completed',
            backgroundColor: kPrimary,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimary,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    get_appointments();
  }
}
