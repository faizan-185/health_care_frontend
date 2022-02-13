import 'package:flutter/material.dart';
import 'package:health_care/config/light_color.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/styles.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  var sK;
  AppBarWidget({Key? key, required this.sK}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: IconButton(
        icon: Icon( Icons.short_text,
          size: 30,
          color: kPrimary,),
        onPressed: () => widget.sK.currentState.openDrawer(),
      ),
      actions: <Widget>[
        Icon(
          Icons.notifications_none,
          size: 30,
          color: kPrimary,
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Image.asset("assets/user.png", fit: BoxFit.fill),
          ),
        ).p(8),
      ],
    );
  }
}
