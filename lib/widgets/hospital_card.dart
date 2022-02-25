import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/light_color.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/widgets/department_button.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HospitalCard extends StatefulWidget {
  String title;
  String address;
  String phone;
  String opening;
  String email;
  String image;
  HospitalCard({Key? key, required this.title, required this.address, required this.phone, required this.opening, required this.email, required this.image}) : super(key: key);

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
        height: 200,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    radius: 40,
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                          child: Text(widget.title, style: normalBlackTitleTextStyle,)),
                      SizedBox(height: 5,),
                      SizedBox(
                        width: 200,
                        child: Text(widget.address, style: style13500,),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(FontAwesomeIcons.phone, color: kPrimary, size: 15),
                    onPressed: (){
                      UrlLauncher.launch("tel://${widget.phone}");
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.phone, style: listTileTitle,),
                  SizedBox(
                    width: 40,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(FontAwesomeIcons.mapMarkedAlt, color: kPrimary, size: 15),
                    onPressed: (){
                      String query = Uri.encodeComponent(widget.title+" "+widget.address);
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
              SizedBox(height: 5,),
              Text(widget.opening, style: listTileTitle,),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(FontAwesomeIcons.at, color: kPrimary, size: 15),
                    onPressed: (){
                      UrlLauncher.launch('mailto:${widget.email}');
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.email, style: listTileTitle,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
