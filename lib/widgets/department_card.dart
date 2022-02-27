import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DepartmentCard extends StatefulWidget {
  String image;
  String name;
  String phone;
  String email;
  DepartmentCard({Key? key, required this.name, required this.email, required this.phone, required this.image}) : super(key: key);

  @override
  _DepartmentCardState createState() => _DepartmentCardState();
}

class _DepartmentCardState extends State<DepartmentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Container(
        width: screenSize.width,
        height: 130,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(Urls.baseUrl+widget.image),
                    radius: 30,
                  ),
                  SizedBox(width: 15,),
                  SizedBox(
                      width: 200,
                      child: Text(widget.name, style: normalBlackTitleTextStyle,)),
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
            ],
          ),
        ),
      ),
    );
  }
}
