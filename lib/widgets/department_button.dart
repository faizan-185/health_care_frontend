import 'package:flutter/material.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/styles.dart';

class DepartmentButton extends StatefulWidget {
  String title;
  DepartmentButton({Key? key, required this.title}) : super(key: key);

  @override
  _DepartmentButtonState createState() => _DepartmentButtonState();
}

class _DepartmentButtonState extends State<DepartmentButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width*0.25,
      child: ElevatedButton(
        child: Text(widget.title, style: style10500,),
        onPressed: (){
          print("Pressed");
        }
      ),
    );
  }
}
