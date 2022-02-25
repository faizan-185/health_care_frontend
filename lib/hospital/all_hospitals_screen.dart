import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/light_color.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/text_styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/models/Hospital.dart';
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:health_care/widgets/hospital_card.dart';

class AllHospitalsScreen extends StatefulWidget {
  const AllHospitalsScreen({Key? key}) : super(key: key);

  @override
  _AllHospitalsScreenState createState() => _AllHospitalsScreenState();
}

class _AllHospitalsScreenState extends State<AllHospitalsScreen> {
  bool status = false;
  bool notFound = false;
  late List<Hospital> hospitals;
  Future<void> getHospitals() async{
    setState(() {
      status = true;
    });
    await getAllHospitals().then((response) {
      if(response.statusCode==200)
        {
          var data = jsonDecode(response.body)['hospital'] as List;
          setState(() {
            hospitals = data.map((hospital) => Hospital.fromJson(hospital)).toList();
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
    getHospitals();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text("All Hospitals", style: secondaryBigHeadingTextStyle).p16;
  }
  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: Icon(Icons.search, color: kPrimary)
                  .alignCenter
                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
      ),
    );
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
          _searchField(),
          SizedBox(height: 10,),
          Container(
            height: screenSize.height-230,
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: hospitals.length,
                itemBuilder: (BuildContext context, int index)
                {
                  return HospitalCard(title: hospitals[index].hospitalName,
                      address: hospitals[index].area+", "+hospitals[index].city+", "+hospitals[index].country+", "+hospitals[index].postalCode,
                      phone: hospitals[index].phoneNo, opening: hospitals[index].openingHours, email: hospitals[index].email,
                      image: Urls.baseUrl+hospitals[index].image,
                  );
                }
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
