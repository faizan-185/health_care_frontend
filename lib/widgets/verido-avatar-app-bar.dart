import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/config/cool_icons_icons.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/services/functions.dart';

PreferredSize buildAvatarAppBar({required BuildContext context}) {
  return PreferredSize(
    preferredSize: Size(double.infinity,
        (screenSize.width < tabletBreakPoint ? 56 : 80) + statusBarHeight),
    child: Container(
      margin: EdgeInsets.only(
          left: screenSize.width < tabletBreakPoint
              ? 20
              : screenSize.width * 0.04,
          right: screenSize.width < tabletBreakPoint
              ? 20
              : screenSize.width * 0.04,
          top: statusBarHeight + 10),
      child: Container(
        alignment: Alignment.centerLeft,
        height: screenSize.width < tabletBreakPoint ? 56 : 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    //Todo: Add Go to profile function
                  },
                  child: ClipRRect(
                    //Todo: Add user DP here
                    child: Container(
                      alignment: Alignment.center,
                      height: screenSize.width < tabletBreakPoint ? 40 : 64,
                      width: screenSize.width < tabletBreakPoint ? 40 : 64,
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${getInitials("Oluwatobi Michael")}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize:
                              screenSize.width < tabletBreakPoint ? 20 : 26,
                          color: kGeneralWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Hi ${getFirstName(fullName: "Oluwatobi Michael")}",
                  style: GoogleFonts.poppins(
                    color: kTextSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: screenSize.width < tabletBreakPoint ? 14 : 24,
                  ),
                )
              ],
            ),
            GestureDetector(
              child: Icon(
                CoolIcons.notification_dot,
                //TODO: CHANGE ICON; WOULD ALSO HAVE VARIANTS
                color: kPrimary,
                size: screenSize.width < tabletBreakPoint ? 24 : 32,
              ),
              onTap: () {
                //  Todo: navigate to notification screen
              },
            ),
          ],
        ),
      ),
    ),
  );
}
