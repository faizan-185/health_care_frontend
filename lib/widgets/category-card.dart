import 'package:flutter/material.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/styles.dart';

class CategoryCard extends StatefulWidget {
  Color color;
  Color lightColor;
  String title;
  String subtitle;
  TextStyle titleStyle;
  TextStyle subtitleStyle;
  CategoryCard({Key? key, required this.color, required this.lightColor, required this.title, required this.subtitle, required this.titleStyle, required this.subtitleStyle}) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
      height: 250,
      width: screenSize.width * 0.412,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: widget.lightColor.withOpacity(0.8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -20,
                left: -20,
                child: CircleAvatar(
                  backgroundColor: kGeneralWhite.withOpacity(0.08),
                  radius: 60,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Text(widget.title, style: widget.titleStyle).hP8,
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      widget.subtitle,
                      style: widget.subtitleStyle,
                    ).hP8,
                  ),
                ],
              ).p16
            ],
          ),
        ),
      ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
