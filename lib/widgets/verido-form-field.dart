import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';

enum VeridoInputType { text, email, password, phone, emailXPhone, number }

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}

TextInputType getKeyboardType({
  required VeridoInputType inputType,
}) {
  switch (inputType) {
    case VeridoInputType.emailXPhone:
      return TextInputType.streetAddress;
      break;

    case VeridoInputType.phone:
      return TextInputType.phone;
      break;

    case VeridoInputType.email:
      return TextInputType.emailAddress;
      break;

    case VeridoInputType.text:
      return TextInputType.text;
      break;

    case VeridoInputType.number:
      return TextInputType.numberWithOptions();
      break;

    case VeridoInputType.password:
      return TextInputType.visiblePassword;
      break;

    default:
      return TextInputType.text;
  }
}

InputDecoration veridoInputDecoration(
    {required VeridoInputType inputType, String? hint}) {
  return InputDecoration(
    suffix: inputType == VeridoInputType.phone
        ? SvgPicture.asset(
            "assets/svg/ngn-flag.svg",
            height: screenSize.width < tabletBreakPoint ? 16 : 24,
          )
        : null,
    fillColor: kFormBG,
    filled: true,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: kRed, width: 1, style: BorderStyle.solid),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: kRed, width: 1, style: BorderStyle.solid),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(
        horizontal: screenSize.width < tabletBreakPoint ? 16 : 24,
        vertical: screenSize.width < tabletBreakPoint ? 16 : 24),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    hintText: hint,
    hintStyle: GoogleFonts.poppins(
        fontSize: screenSize.width < tabletBreakPoint ? 16 : 18,
        fontWeight: FontWeight.w600,
        color: kInactive),
  );
}

String? fullNameValidator(value) {
  if (value == null || value.isEmpty) {
    return 'your name cannot be empty';
  }
  if (value.trim().length < 3) {
    return 'please type in your full name';
  } else if (!value.trim().toString().contains(" ")) {
    return 'your first name and last names are required';
  } else {
    return null;
  }
}

String? emailValidator(value) {
  if (value == null || value.isEmpty) {
    return 'email address is required';
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'email address is not valid';
  } else {
    return null;
  }
}

String? textValidator(value){
  if (value == null || value.isEmpty)
    return "Cannot be empty!";
  else
    return null;
}

String? optionalEmailValidator(value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'email address is not valid';
  } else {
    return null;
  }
}

String? passwordValidator(value) {
  if (value == null || value.isEmpty) {
    return 'your password is required';
  }
  if (value.trim().length < 8) {
    return 'your password must contain at least 8 characters';
  } else {
    return null;
  }
}

String? numberValidator(value) {
  if (value == null || value.isEmpty) {
    return 'this field is required';
  }
  if (!isNumeric(value)) {
    return 'this field must only contain digits';
  } else {
    return null;
  }
}

String? phoneValidator(value) {
  if (value == null || value.isEmpty) {
    return 'phone number cannot be empty';
  }
  if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
    return 'invalid phone number';
  } else {
    return null;
  }
}
