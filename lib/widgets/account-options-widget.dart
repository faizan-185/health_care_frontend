
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/config/cool_icons_icons.dart';
import 'package:health_care/config/styles.dart';

class VeridoOptionTile extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final IconData iconData;
  const VeridoOptionTile({
    Key? key,
    required this.title,
    this.onPressed,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.only(left: 18, right: 16),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFF3A87FD).withOpacity(.1),
            offset: Offset(0, 5),
            spreadRadius: 0,
            blurRadius: 20,
          ),
        ], borderRadius: BorderRadius.circular(10), color: kGeneralWhite),
        child: Row(
          children: [
            Icon(
              iconData,
              color: kPrimary,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                "$title",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kPrimary),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Icon(
              CoolIcons.chevron_big_right,
              color: kInactive,
            ),
          ],
        ),
      ),
    );
  }
}
