import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:health_care/config/extention.dart';

class DoctorCard extends StatefulWidget {
  String name;
  String qAnds;
  String phone;
  String availability;
  String email;
  String image;
  DoctorCard({Key? key, required this.name, required this.qAnds, required this.phone, required this.availability, required this.email, required this.image}) : super(key: key);

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: 160,
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
                        child: Text(widget.name, style: normalBlackTitleTextStyle,)),
                    SizedBox(height: 5,),
                    SizedBox(
                      width: 200,
                      child: Text(widget.qAnds, style: style13500,),
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
                Spacer(),
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
                SizedBox(width: screenSize.width*0.4, child: Text(widget.email, style: listTileTitle,)),
              ],
            ),
            SizedBox(height: 5,),
            Text(widget.availability, style: listTileTitle,),
          ],
        ),
      ),
    ).vP8;
  }
}
