import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/Pharmacy.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../config/dimensions.dart';
import '../config/styles.dart';

class PharmacyCard extends StatefulWidget {
  Pharmacy pharmacy;
  PharmacyCard({Key? key, required this.pharmacy}) : super(key: key);

  @override
  State<PharmacyCard> createState() => _PharmacyCardState();
}

class _PharmacyCardState extends State<PharmacyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 16.00, right: 16.00),
      child: Container(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 200,
                      child: Text(widget.pharmacy.pharmacyName, style: normalBlackTitleTextStyle,)),
                  SizedBox(height: 5,),
                  SizedBox(
                    width: 200,
                    child: Text(widget.pharmacy.area + " " + widget.pharmacy.city + " " + widget.pharmacy.country + ", " + widget.pharmacy.postalCode, style: style13500,),
                  ),
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
                      UrlLauncher.launch("tel://${widget.pharmacy.phoneNo}");
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.pharmacy.phoneNo, style: listTileTitle,),
                  SizedBox(
                    width: 40,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(FontAwesomeIcons.mapMarkedAlt, color: kPrimary, size: 15),
                    onPressed: (){
                      String query = Uri.encodeComponent(widget.pharmacy.pharmacyName+" "+widget.pharmacy.area + " " + widget.pharmacy.city);
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
              //Text(widget.opening, style: listTileTitle,),
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
                      UrlLauncher.launch('mailto:${widget.pharmacy.email}');
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.pharmacy.email, style: listTileTitle,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
