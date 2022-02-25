import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/light_color.dart';
import 'package:health_care/config/styles.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HospitalCard extends StatefulWidget {
  const HospitalCard({Key? key}) : super(key: key);

  @override
  _HospitalCardState createState() => _HospitalCardState();
}

class _HospitalCardState extends State<HospitalCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 16.00, right: 16.00),
      child: Container(
        width: screenSize.width,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 8,
              color: Colors.blueGrey.withOpacity(0.8),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: LightColor.lightBlue,
                    radius: 40,
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                          child: Text("Bahawalpur Victoria Hospital", style: normalBlackTitleTextStyle,)),
                      SizedBox(height: 5,),
                      SizedBox(
                        width: 200,
                        child: Text("Ghurki St. Minahala Road Jallo More"
                          " Post Office Bata Pura, GT RD-Burki Rd Link, Lahore. 95600", style: style13500,),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(FontAwesomeIcons.phone, color: kPrimary, size: 15),
                            onPressed: (){
                              print("pressed");
                              UrlLauncher.launch("tel://03024716712");
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("402 375 5216", style: listTileTitle,)
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
