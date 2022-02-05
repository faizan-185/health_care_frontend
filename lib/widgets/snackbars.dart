import 'package:flutter/material.dart';
import 'package:health_care/config/styles.dart';

SnackBar snackBarError(String title)
{
  return SnackBar(
    backgroundColor: kRedLight,
    content: Text(title, style: snackBarErrorStyle),
    dismissDirection: DismissDirection.startToEnd,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    behavior: SnackBarBehavior.floating,
  );
}

SnackBar snackBarSuccess(String title)
{
  return SnackBar(
    backgroundColor: kGreenLight,
    content: Text(title, style: snackBarSuccessStyle),
    dismissDirection: DismissDirection.startToEnd,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    behavior: SnackBarBehavior.floating,
  );
}