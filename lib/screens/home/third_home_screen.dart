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
import 'package:health_care/logs/Log.dart';
import 'package:health_care/models/appointment.dart';
import 'package:health_care/screens/appointments/upcoming.dart';
import 'package:health_care/services/api_funtions/appointment_requests.dart';
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/services/api_funtions/pharmacy_functions.dart';
import 'package:health_care/services/api_funtions/vendor_functions.dart';
import 'package:health_care/services/functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/category-card.dart';
import 'package:health_care/widgets/doctor_drawer.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:health_care/widgets/vendor_drawer.dart';

import '../../logs/db_helper.dart';


class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {

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
  int postCount = 0;
  int responseCount = 0;
  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime getDateTime(String dateTime)
  {
    String dt = dateTime.split(' At ').join(" ");
    return DateTime.parse(dt);
  }

  void getPosts() async
  {
    setState(() {
      status = true;
    });
    await getAllPosts().then((value) {
      if(value.statusCode == 200)
        {
          setState(() {
            status = false;
          });
          var data = jsonDecode(value.body)['post'];
          setState(() {
            postCount = data.length;
          });
        }
    });
  }

  void getResponses() async {
    setState(() {
      status = true;
    });
    await getMyResponses().then((value) {
      setState(() {
        status = false;
        responseCount = value.length;
      });
    });
  }

  var handler;

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
    getPosts();
    getResponses();
    handler = DatabaseHandler();

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
      drawer: ThirdDrawer(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          _searchField(),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 200,
            width: screenSize.width,
            child: ListView(
              padding: EdgeInsets.only(left: 10),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/AllPosts');
                  },
                  child: AbsorbPointer(
                    child: CategoryCard(color: color[0], lightColor: lightColor[0], title: "All Posts",
                      subtitle: "${postCount} posts", titleStyle: authSubTextStyle1,
                      subtitleStyle: floatingButtonText, ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/MyResponses');
                  },
                  child: AbsorbPointer(
                    child: CategoryCard(color: color[1], lightColor: lightColor[1], title: "My Responses",
                        subtitle: "${responseCount} responses", titleStyle: authSubTextStyle1, subtitleStyle: floatingButtonText),
                  ),
                ),
                // CategoryCard(color: color[2], lightColor: lightColor[2], title: "Ambulance Services",
                //     subtitle: "more than 100", titleStyle: authSubTextStyle1, subtitleStyle: floatingButtonText),
              ],
            ),
          ),
          Text("Recent Activities", style: secondaryBigHeadingTextStyle).hP16,
          SizedBox(height: 10,),
          // FutureBuilder(
          //   future: handler.retrieveDrLogs(),
          //   builder: (BuildContext context, AsyncSnapshot<List<DrLog>> snapshot) {
          //     if (snapshot.hasData) {
          //       return ListView.builder(
          //         reverse: true,
          //         shrinkWrap: true,
          //         itemCount: snapshot.data?.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Dismissible(
          //             direction: DismissDirection.endToStart,
          //             background: Container(
          //               color: Colors.red,
          //               alignment: Alignment.centerRight,
          //               padding: EdgeInsets.symmetric(horizontal: 10.0),
          //               child: Icon(Icons.delete_forever),
          //             ),
          //             key: ValueKey<int>(snapshot.data![index].id!),
          //             onDismissed: (DismissDirection direction) async {
          //               await handler.deleteUser(snapshot.data![index].id!);
          //               setState(() {
          //                 snapshot.data!.remove(snapshot.data![index]);
          //               });
          //             },
          //             child: Card(
          //                 elevation: 3.0,
          //                 child: ListTile(
          //                   isThreeLine: true,
          //                   leading: Icon(snapshot.data![index].type == "accept" ? FontAwesomeIcons.check : FontAwesomeIcons.times, color: kPrimary, ),
          //                   title: Text(snapshot.data![index].type == "accept" ? "Accepted Appointment" : "Rejected Appointment", style: normalBlackTitleTextStyle,),
          //                   subtitle: Column(
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(snapshot.data![index].name, style: listTileTitle,),
          //                       Text(snapshot.data![index].datetime.split('.')[0], style: style13500,)
          //                     ],
          //                   ),
          //                 )),
          //           );
          //         },
          //       );
          //     } else {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ).hP16,
        ],
      ),
    );
  }
}
