import 'dart:convert';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
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
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/services/api_funtions/pharmacy_functions.dart';
import 'package:health_care/services/functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/category-card.dart';
import 'package:health_care/widgets/drawer.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../logs/db_helper.dart';

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
  int pharmacyCount = 0;
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

  Future<void> getPharmaciesCount()async{
    setState(() {
      status = true;
    });
    await getAllPharmacies().then((value) {
      var data = jsonDecode(value.body);
      if(value.statusCode==200)
      {
        data = data['pharmacy'];
        setState(() {
          pharmacyCount = data.length;
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

  // Future<void> initPlatform() async{
  //   setState(() {
  //     status = true;
  //   });
  //   await OneSignal.shared.setAppId("ddf6aba3-5073-4ab2-b8d5-0e0dfe83439f");
  //   await OneSignal.shared.getDeviceState().then((value) {
  //     print("----------------------------userid-----------------------------");
  //     print(value!.userId);
  //
  //   });
  //   setState(() {
  //     status = false;
  //   });
  // }
  //
  // void initFirebase() async{
  //   setState(() {
  //     status = true;
  //   });
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   setState(() {
  //     status = false;
  //   });
  //
  // }

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
    getHospitalCount();
    getPharmaciesCount();
    handler = DatabaseHandler();
    // initFirebase();
    // initPlatform();
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
            height: 200,
            width: screenSize.width,
            child: ListView(
              padding: EdgeInsets.only(left: 10),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/AllHospitalsScreen');
                  },
                  child: AbsorbPointer(
                    child: CategoryCard(color: color[0], lightColor: lightColor[0], title: "Finding a Cure?",
                      subtitle: hospitalCount.toString()+" Hospitals", titleStyle: authSubTextStyle1,
                      subtitleStyle: floatingButtonText, ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/AllPharmacies');
                  },
                  child: AbsorbPointer(
                    child: CategoryCard(color: color[1], lightColor: lightColor[1], title: "Looking for Meds?",
                        subtitle: "${pharmacyCount} Pharmacies", titleStyle: authSubTextStyle1, subtitleStyle: floatingButtonText),
                  ),
                ),
                // CategoryCard(color: color[2], lightColor: lightColor[2], title: "Ambulance Services",
                //     subtitle: "more than 100", titleStyle: authSubTextStyle1, subtitleStyle: floatingButtonText),
              ],
            ),
          ),
          Text("Recent Activities", style: secondaryBigHeadingTextStyle).hP16,
          SizedBox(height: 10,),
          FutureBuilder(
            future: handler.retrieveLogs(),
            builder: (BuildContext context, AsyncSnapshot<List<Log>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(Icons.delete_forever),
                      ),
                      key: ValueKey<int>(snapshot.data![index].id!),
                      onDismissed: (DismissDirection direction) async {
                        await handler.deleteUser(snapshot.data![index].id!);
                        setState(() {
                          snapshot.data!.remove(snapshot.data![index]);
                        });
                      },
                      child: Card(
                        elevation: 3.0,
                          child: ListTile(
                            isThreeLine: true,
                            leading: Icon(snapshot.data![index].type == "order" ? FontAwesomeIcons.luggageCart : FontAwesomeIcons.calendarCheck, color: kPrimary, ),
                            title: Text(snapshot.data![index].type == "order" ? "Purchased Meds" : "Scheduled Appointment", style: normalBlackTitleTextStyle,),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].name, style: listTileTitle,),
                                Text(snapshot.data![index].datetime.split('.')[0], style: style13500,)
                              ],
                            ),
                            trailing: Text(snapshot.data![index].type == "order" ? "Rs. " + snapshot.data![index].bill : "", style: listTilePrice,),
                          )),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ).hP16,

        ],
      ),
    );
  }
}
