import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dimensions.dart';

Color kGeneralWhite = Color(0xFFFFFFFF);
Color kBackground = Color(0xFFFAFAFA);
//Color kPrimary = Color(0xFF08A730);
Color kPrimary = Color(0xFF0985FA);
Color kTextPrimary = Color(0xFF000000);
Color kTextSecondary = Color(0xFF333333);
Color kTextGray = Color(0xFF60708F);
Color kInactive = Color(0xFFAEAEB2);
Color kBlueLight = Color(0xFFE6FAFF);
Color kGreen = Color(0xFF34C759);
Color kGreenLight = Color(0xFFECFBEC);
Color kRed = Color(0xFFFF3B30);
Color kRedLight = Color(0xFFFFF0F4);
Color kFormBG = Color(0xFFF2F2F7);
Color kBlue = Color(0xFF094AFA);
Color kPurple = Color(0xFFDB0FA2);
Gradient kBlueGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft, // 10% of the width, so there are ten blinds.
  colors: <Color>[
    Color(0xFF0985FA),
    Color(0xFF094AFA),
  ],
);
Gradient kYellowGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft, // 10% of the width, so there are ten blinds.
  colors: <Color>[
    Color(0xFFFEC810),
    Color(0xFFF8981D),
  ],
);
Gradient kGreenGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft, // 10% of the width, so there are ten blinds.
  colors: <Color>[
    Color(0xFF48D27E),
    Color(0xFF05BA4C),
  ],
);
Gradient kPurpleGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft, // 10% of the width, so there are ten blinds.
  colors: <Color>[
    Color(0xFFFF6FD7),
    Color(0xFFDB0FA2),
  ],
);
Gradient kWineGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight, // 10% of the width, so there are ten blinds.
  colors: <Color>[
    Color(0xFFE42C66),
    Color(0xFFF55B46),
  ],
);
TextStyle bigHeadingTextStyle = GoogleFonts.poppins(
  color: kGeneralWhite,
  fontSize: 28,
  fontWeight: FontWeight.w600,
);

TextStyle bigHeadingPrimaryTextStyle = GoogleFonts.poppins(
  color: kPrimary,
  fontSize: 28,
  fontWeight: FontWeight.w600,
);

TextStyle secondaryBigHeadingTextStyle = GoogleFonts.poppins(
  color: kTextPrimary,
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

TextStyle mainHeadingTextStyle = GoogleFonts.poppins(
  color: kGeneralWhite,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

TextStyle mainHeadingTextStyle1 = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

TextStyle secondaryHeadingTextStyle = GoogleFonts.poppins(
  color: kBackground,
  fontSize: 18,
  fontWeight: FontWeight.w400,
);

TextStyle normalBlackTitleTextStyle = GoogleFonts.poppins(
  color: kTextPrimary,
  fontSize: screenSize.width < tabletBreakPoint ? 18 : 24,
  fontWeight: FontWeight.w600,
);

TextStyle myAccount = GoogleFonts.poppins(
  color: kTextPrimary,
  fontSize: screenSize.width < tabletBreakPoint ? 18 : 24,
  fontWeight: FontWeight.w500,
);

TextStyle myAccountName = GoogleFonts.poppins(
  color: kPrimary,
  fontSize: screenSize.width < tabletBreakPoint ? 18 : 24,
  fontWeight: FontWeight.w500,
);

TextStyle listTileTitle = GoogleFonts.poppins(
  color: kTextPrimary,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

TextStyle listTileTitleRed = GoogleFonts.poppins(
  color: kRed,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

TextStyle listTileUnit = GoogleFonts.poppins(
  color: kTextPrimary,
  fontSize: 10,
  fontWeight: FontWeight.w400,
);



TextStyle authSubTextStyle1 = GoogleFonts.poppins(
  color: kGeneralWhite,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

TextStyle style20600 = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

TextStyle floatingButtonText = GoogleFonts.poppins(
  color: kGeneralWhite,
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

TextStyle style10500 = GoogleFonts.poppins(
  color: kGeneralWhite,
  fontSize: 10,
  fontWeight: FontWeight.w500,
);

TextStyle style13500 = GoogleFonts.poppins(
  color: kTextGray,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

TextStyle snackBarErrorStyle = GoogleFonts.poppins(
  color: kRed,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
TextStyle snackBarSuccessStyle = GoogleFonts.poppins(
  color: kPrimary,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle listTilePrice = GoogleFonts.poppins(
  color: kPrimary,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle listTilePriceRed = GoogleFonts.poppins(
  color: kRed,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle style14600Green = GoogleFonts.poppins(
    color: kGreen,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 14 : 18);

TextStyle kFormTextStyle = GoogleFonts.poppins(
    color: kTextPrimary,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 14 : 18);
TextStyle kFormTextStyle1 = GoogleFonts.poppins(
    color: kGeneralWhite,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 14 : 18);
TextStyle kFormTextStyle2 = GoogleFonts.poppins(
    color: kTextPrimary,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 25 : 19);
TextStyle kFormTextStyle3 = GoogleFonts.poppins(
    color: kGeneralWhite,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 25 : 19);
TextStyle kFormTitleTextStyle = GoogleFonts.poppins(
    color: kTextSecondary,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 14 : 18);

TextStyle style14500grey = GoogleFonts.poppins(
    color: kTextSecondary,
    fontWeight: FontWeight.w500,
    fontSize: screenSize.width < tabletBreakPoint ? 14 : 18);

TextStyle kPrimaryButtonTextStyle = GoogleFonts.poppins(
    color: kGeneralWhite,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 16 : 20);
TextStyle kLightButtonTextStyle = GoogleFonts.poppins(
    color: kPrimary,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 12 : 20);
TextStyle seeMoreStyle = GoogleFonts.poppins(
    color: kPrimary, fontWeight: FontWeight.w500, fontSize: 12);
TextStyle detailHeadings = GoogleFonts.poppins(
    color: kTextGray, fontWeight: FontWeight.w500, fontSize: 12);
TextStyle detailData = GoogleFonts.poppins(
    color: kTextPrimary, fontWeight: FontWeight.w500, fontSize: 20);
TextStyle detailData1 = GoogleFonts.poppins(
    color: kTextPrimary, fontWeight: FontWeight.w500, fontSize: 14);
TextStyle detailData2 = GoogleFonts.poppins(
    color: kTextPrimary, fontWeight: FontWeight.w600, fontSize: 17);
TextStyle detailData3 = GoogleFonts.poppins(
    color: kTextPrimary, fontWeight: FontWeight.w400, fontSize: 13);

TextStyle tagsStyle(color) {
  return GoogleFonts.poppins(
      color: color, fontWeight: FontWeight.w500, fontSize: 10);
}

TextStyle style12400 = GoogleFonts.poppins(
    color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12);
TextStyle style12400Orange = GoogleFonts.poppins(
    color: Colors.orange, fontWeight: FontWeight.w400, fontSize: 12);
TextStyle style12400Green = GoogleFonts.poppins(
    color: Colors.green, fontWeight: FontWeight.w400, fontSize: 12);
TextStyle operationSubheading = GoogleFonts.poppins(
    color: kGeneralWhite, fontWeight: FontWeight.w500, fontSize: 14);
TextStyle style14500 = GoogleFonts.poppins(
    color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14);
TextStyle style14500Black = GoogleFonts.poppins(
    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14);
TextStyle style14600 = GoogleFonts.poppins(
    color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14);
TextStyle videoTagsStyle = GoogleFonts.poppins(
    color: kPrimary, fontWeight: FontWeight.w500, fontSize: 10);
TextStyle kSecondaryButtonTextStyle = GoogleFonts.poppins(
    color: kPrimary,
    fontWeight: FontWeight.w600,
    fontSize: screenSize.width < tabletBreakPoint ? 16 : 20);

TextStyle kSecondaryButtonTextStyle1 = GoogleFonts.poppins(
    color: kPrimary,
    fontSize: screenSize.width < tabletBreakPoint ? 14 : 18);

TextStyle kAuthSubText2Style = GoogleFonts.poppins(
    color: kTextSecondary,
    fontSize: screenSize.width < tabletBreakPoint ? 14 : 18);
TextStyle kAuthSubText2Style2 = GoogleFonts.poppins(
    color: kGeneralWhite,
    fontSize: screenSize.width < tabletBreakPoint ? 14 : 18);
TextStyle kAuthSubText2Style1 = GoogleFonts.poppins(
    color: kTextSecondary,
    fontSize: screenSize.width < tabletBreakPoint ? 21 : 25);

SystemUiOverlayStyle appSystemLightTheme = SystemUiOverlayStyle.light
    .copyWith(
        systemNavigationBarColor: kBackground,
        systemNavigationBarIconBrightness: Brightness.dark);

SystemUiOverlayStyle appSystemGreenTheme = SystemUiOverlayStyle.light
    .copyWith(
        systemNavigationBarColor: Color(0xFF04A141),
        systemNavigationBarIconBrightness: Brightness.light);

TextStyle kSubTitleStyle = GoogleFonts.poppins(
  color: kTextGray,
  fontSize: screenSize.width < tabletBreakPoint ? 20 : 32,
  fontWeight: FontWeight.w600,
);
TextStyle kSubTextStyle = GoogleFonts.poppins(
  color: kTextGray,
  fontSize: screenSize.width < tabletBreakPoint ? 13 : 16,
);
