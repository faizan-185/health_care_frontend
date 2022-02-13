import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/light_color.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/text_styles.dart';
import 'package:health_care/config/themes.dart';
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/services/functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/category-card.dart';
import 'package:health_care/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final colorList = [
    LightColor.green,
    LightColor.orange,
    LightColor.purple,
    LightColor.skyBlue,
  ];
  final lightColors = [
    LightColor.lightGreen,
    LightColor.lightOrange,
    LightColor.purpleLight,
    LightColor.lightBlue
  ];
  var color = [];
  var lightColor = [];
  TextStyle titleStyle = TextStyles.title.bold.white;
  TextStyle subtitleStyle = TextStyles.body.bold.white;
  int hospitalCount = 0;
  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> getHospitalCount()async{
    setState(() {
      status = true;
    });
    await getAllHospitals().then((value) {
      var data = jsonDecode(value.body);
      if(value.statusCode==200)
      {
        data = data['hospital'];
        setState(() {
          hospitalCount = data.length;
        });
      }
      else{
        print(data['message']);
      }
    });
    setState(() {
      status = false;
    });
  }

  @override
  void initState() {
    super.initState();
    var added = [-1, -1, -1, -1, -1];
    for(int i=0; i<5; i++)
      {
        bool stat = true;
        var random = Random();
        int ind = random.nextInt(colorList.length);
        for(int j = 0; j<colorList.length; j++){
          if(ind==added[j])
            stat = false;
          else
            added.add(ind);
        }
        if(stat)
          {
            color.add(colorList[ind]);
            lightColor.add(lightColors[ind]);
          }
      }
    getHospitalCount();
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello,", style: normalBlackTitleTextStyle),
        Text(UserLoginData.displayName, style: secondaryBigHeadingTextStyle),
      ],
    ).p16;
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          _searchField(),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: screenSize.height * 0.28,
            width: screenSize.width,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                CategoryCard(color: color[0], lightColor: lightColor[0], title: "Finding a Cure?", subtitle: hospitalCount.toString()+" Hospitals", titleStyle: authSubTextStyle1, subtitleStyle: floatingButtonText,),
                CategoryCard(color: color[1], lightColor: lightColor[1], title: "Looking for Meds?", subtitle: "200+ Pharmacies", titleStyle: authSubTextStyle1, subtitleStyle: floatingButtonText),
                CategoryCard(color: color[2], lightColor: lightColor[2], title: "Ambulance Services", subtitle: "more than 100", titleStyle: authSubTextStyle1, subtitleStyle: floatingButtonText),
              ],
            ),
          )
        ],
      ),
    );
  }
}
