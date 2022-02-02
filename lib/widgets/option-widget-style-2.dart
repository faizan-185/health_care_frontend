import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/config/cool_icons_icons.dart';
import 'package:health_care/config/styles.dart';

class VeridoOptionTile2 extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final IconData iconData;
  const VeridoOptionTile2({
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
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.only(left: 18, right: 16),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kGreenLight),
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
                    color: kTextSecondary),
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
