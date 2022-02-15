import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/services/api_funtions/password_reset_functions.dart';
import 'package:health_care/widgets/snackbars.dart';
import 'package:health_care/widgets/verido-form-field.dart';
import 'package:health_care/widgets/verido-primary-button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {


  final _formKey = GlobalKey<FormState>();
  Icon _passwordSuffix = Icon(
    CupertinoIcons.eye,
    size: 16,
    color: kPrimary,
  );
  bool _passwordHide = true;
  TextEditingController _passwordController = TextEditingController();

  Icon _confirmPasswordSuffix = Icon(
    CupertinoIcons.eye,
    size: 16,
    color: kPrimary,
  );
  bool _confirmPasswordHide = true;
  bool status = false;

  String? _confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'your password is required';
    }
    if (value.trim().length < 8) {
      return 'your password must contain at least 8 characters';
    }
    if (value != _passwordController.text) {
      return "both passwords are not the same";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackground,
        iconTheme: IconThemeData(
            color: kPrimary
        ),
      ),
      backgroundColor: kBackground,
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(
            height: screenSize.height*0.03,
          ),
          Text(
            "Choose your new Password",
            style: normalBlackTitleTextStyle,
          ),
          SizedBox(
            height: 40,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Password",
                      style: kFormTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _passwordHide,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.password),
                      style: kFormTextStyle,
                      validator: passwordValidator,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: _passwordSuffix,
                          onPressed: () {
                            if (_passwordHide) {
                              setState(() {
                                _passwordHide = false;
                                _passwordSuffix = Icon(
                                  CupertinoIcons.eye_slash,
                                  size: 16,
                                  color: kPrimary,
                                );
                              });
                            } else {
                              setState(() {
                                _passwordHide = true;
                                _passwordSuffix = Icon(
                                  CupertinoIcons.eye,
                                  size: 16,
                                  color: kPrimary,
                                );
                              });
                            }
                          },
                        ),
                        fillColor: kFormBG,
                        filled: true,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: kRed,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: kRed,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal:
                            screenSize.width < tabletBreakPoint
                                ? 16
                                : 24,
                            vertical:
                            screenSize.width < tabletBreakPoint
                                ? 16
                                : 24),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "your new password",
                        hintStyle: GoogleFonts.poppins(
                            fontSize:
                            screenSize.width < tabletBreakPoint
                                ? 16
                                : 18,
                            fontWeight: FontWeight.w600,
                            color: kInactive),
                      ),
                    ),
                    SizedBox(
                      height:
                      screenSize.width < tabletBreakPoint ? 24 : 30,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm Password",
                      style: kFormTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: _confirmPasswordHide,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.password),
                      style: kFormTextStyle,
                      validator: _confirmPasswordValidator,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: _confirmPasswordSuffix,
                          onPressed: () {
                            if (_confirmPasswordHide) {
                              setState(() {
                                _confirmPasswordHide = false;
                                _confirmPasswordSuffix = Icon(
                                  CupertinoIcons.eye_slash,
                                  size: 16,
                                  color: kPrimary,
                                );
                              });
                            } else {
                              setState(() {
                                _confirmPasswordHide = true;
                                _confirmPasswordSuffix = Icon(
                                  CupertinoIcons.eye,
                                  size: 16,
                                  color: kPrimary,
                                );
                              });
                            }
                          },
                        ),
                        fillColor: kFormBG,
                        filled: true,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: kRed,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: kRed,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal:
                            screenSize.width < tabletBreakPoint
                                ? 16
                                : 24,
                            vertical:
                            screenSize.width < tabletBreakPoint
                                ? 16
                                : 24),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "confirm new password",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: screenSize.width < tabletBreakPoint
                              ? 16
                              : 18,
                          fontWeight: FontWeight.w600,
                          color: kInactive,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                      screenSize.width < tabletBreakPoint ? 24 : 30,
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: screenSize.width*0.5,
                  child: status ? Center(child: CircularProgressIndicator(color: kPrimary,)) : VeridoPrimaryButton(
                    title: Text(
                      "Reset Password",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kPrimaryButtonTextStyle,
                    ),
                    onPressed: ()  {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          status = true;
                        });
                        resetPassword(UserLoginData.userId, _passwordController.text).then((response) {
                          var data = jsonDecode(response.body);
                          if(response.statusCode==200)
                            {
                              setState(() {
                                status = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess(data['message']));
                              Navigator.pushNamedAndRemoveUntil(context, "/LoginScreen", (route) => false);
                            }
                          else
                            {
                              setState(() {
                                status = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(snackBarError(data['message']));
                            }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
