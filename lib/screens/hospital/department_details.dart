import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/models/Department.dart';
import 'package:health_care/models/DoctorInDepartment.dart';
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/doctor_card.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DepartmentDetails extends StatefulWidget {
  Department department;
  DepartmentDetails({Key? key, required this.department}) : super(key: key);

  @override
  _DepartmentDetailsState createState() => _DepartmentDetailsState();
}

class _DepartmentDetailsState extends State<DepartmentDetails> {
  bool status = false;
  bool notFound = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var doctors = [];
  Future<void> getDrInDepartment() async{
    setState(() {
      status = true;
    });
    await getAllDoctorsOfDepartment(widget.department.departmentId).then((response) {
      if(response.statusCode==200)
      {
        var data = jsonDecode(response.body)['drInDepart'] as List;
        setState(() {
          doctors = data.map((e) => DrInDepart.fromJson(e)).toList();
          status = false;
        });
      }
      else
      {
        setState(() {
          status = false;
          notFound = true;
        });
      }
    });
  }
  @override
  void initState() {
    getDrInDepartment();
    super.initState();
  }
  Widget _header() {
    return SizedBox(width: screenSize.width, child: Text(widget.department.departmentName, style: secondaryBigHeadingTextStyle));
  }
  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackground,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(Urls.baseUrl+widget.department.image),
                  fit: BoxFit.fill
              ),
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Call us at:", style: listTilePrice,),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.phone, color: kPrimary, size: 15),
                      onPressed: (){
                        UrlLauncher.launch("tel://${widget.department.phoneNo}");
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.department.phoneNo, style: listTileTitle,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email us at:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.at, color: kPrimary, size: 15),
                      onPressed: (){
                        UrlLauncher.launch('mailto:${widget.department.email}');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(width: screenSize.width*0.4, child: Text(widget.department.email, style: listTileTitle,)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text("All Doctors:", style: listTilePrice,),
          doctors.length==0 ? Center(child: Text("No Departments", style: snackBarErrorStyle,)) : ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: doctors.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: (){
                    //Navigator.push(context, new MaterialPageRoute(builder: (context) => DepartmentDetails(department: departments[index])));
                  },
                  child: DoctorCard(name: doctors[index].doctor.user.displayName,
                    phone: doctors[index].doctor.user.phoneNumber, email: doctors[index].doctor.user.email,
                    image: doctors[index].doctor.user.image,
                    qAnds: doctors[index].doctor.specialization.details+", "+
                        doctors[index].doctor.qualification.details,
                    availability: doctors[index].doctor.availablityDays+" "+doctors[index].doctor.activeHours,
                  ),
                );
              }
          )
        ],
      ),
    );
  }
}
