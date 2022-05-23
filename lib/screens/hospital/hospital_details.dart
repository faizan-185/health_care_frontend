import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/models/Department.dart';
import 'package:health_care/models/Hospital.dart';
import 'package:health_care/screens/hospital/department_details.dart';
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/department_card.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HospitalDetails extends StatefulWidget {
  Hospital hospital;
  HospitalDetails({Key? key, required this.hospital}) : super(key: key);

  @override
  _HospitalDetailsState createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  bool status = false;
  bool notFound = false;
  var departments = [];
  int departmentCount = 0;
  Future<void> getDepartments() async{
    setState(() {
      status = true;
    });
    await getAllDepartments().then((response) {
      if(response.statusCode==200)
      {
        var data = jsonDecode(response.body)['department'] as List;
        setState(() {
          departments = data.map((e) => Department.fromJson(e)).toList();
          status = false;
          departments.forEach((element) {
            if(element.hospital.hospitalId==widget.hospital.hospitalId)
              {
                departmentCount++;
              }
          });
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
    getDepartments();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return SizedBox(width: screenSize.width, child: Text(widget.hospital.hospitalName, style: secondaryBigHeadingTextStyle));

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
                image: NetworkImage(Urls.baseUrl+widget.hospital.image),
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
              Text("Address:", style: listTilePrice,),
              SizedBox(
                width: screenSize.width*0.5,
                child: Text(widget.hospital.area+" "+widget.hospital.city+" "
                    +widget.hospital.country+". "+widget.hospital.postalCode, style: listTileTitle,),
              ),
            ],
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
                        UrlLauncher.launch("tel://${widget.hospital.phoneNo}");
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.hospital.phoneNo, style: listTileTitle,),
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
              Text("Reach to us:", style: listTilePrice,),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.mapMarkedAlt, color: kPrimary, size: 15),
                      onPressed: (){
                        String query = Uri.encodeComponent(widget.hospital.hospitalName+" "+widget.hospital.city);
                        String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
                        UrlLauncher.launch(googleUrl);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Open Map", style: listTileTitle,),
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
              Text("Availability:", style: listTilePrice,),
              Spacer(),
              SizedBox(width: screenSize.width*0.5, child: Text(widget.hospital.openingHours, style: listTileTitle,)),
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
                        UrlLauncher.launch('mailto:${widget.hospital.email}');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(width: screenSize.width*0.4, child: Text(widget.hospital.email, style: listTileTitle,)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text("All Departments:", style: listTilePrice,),
          departmentCount==0 ? Center(child: Text("No Departments", style: snackBarErrorStyle,)) : ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            itemCount: departments.length,
            itemBuilder: (BuildContext context, int index){
              if(departments[index].hospital.hospitalId == widget.hospital.hospitalId)
                {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => DepartmentDetails(department: departments[index])));
                    },
                    child: DepartmentCard(name: departments[index].departmentName,
                      phone: departments[index].phoneNo, email: departments[index].email,
                      image: departments[index].image,
                    ),
                  );
                }
              else
                {
                  return SizedBox(height: 0,);
                }
            }
          )
        ],
      ),
    );
  }
}
