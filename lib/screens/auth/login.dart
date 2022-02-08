import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/services/api_funtions/login_functions.dart';
import 'package:health_care/widgets/snackbars.dart';
import 'package:health_care/widgets/verido-form-field.dart';
import 'package:health_care/widgets/verido-primary-button.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Icon _passwordSuffix = Icon(
    CupertinoIcons.eye,
    size: 16,
    color: kPrimary,
  );
  bool _passwordHide = true;
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: screenSize.height*0.15,),
          Text("Welcome", style: bigHeadingPrimaryTextStyle,),
          SizedBox(
            height: screenSize.height*0.07,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: kFormTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.email),
                      style: kFormTextStyle,
                      validator: emailValidator,
                      decoration: veridoInputDecoration(
                          inputType: VeridoInputType.email,
                          hint: "abc@xxx.xyz"),
                    ),
                    SizedBox(
                      height: screenSize.width < tabletBreakPoint
                          ? 24
                          : 30,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: kFormTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: _passwordHide,
                      controller: _passwordController,
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
                        hintText: "your password",
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
                      height: screenSize.width < tabletBreakPoint
                          ? 24
                          : 30,
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/OtpScreen');
                    },
                    child: Text(
                      'forgot password',
                      style: GoogleFonts.poppins(
                          fontSize:
                          screenSize.width < tabletBreakPoint
                              ? 14
                              : 16,
                          color: kPrimary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                progress ? CircularProgressIndicator(color: kPrimary,) :
                SizedBox(
                  width: screenSize.width*0.5,
                  child: VeridoPrimaryButton(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign In",
                          style: kPrimaryButtonTextStyle,
                        ),
                      ],
                    ),
                    onPressed: () {
                      if(_formKey.currentState?.validate() == true) {
                        setState(() {
                          progress = true;
                        });
                        login(_emailController.text, _passwordController.text)
                            .then((response) {
                              setState(() {
                                progress = false;
                              });
                              var data = jsonDecode(response.body);
                              if(response.statusCode==200)
                                {
                                  if(data['isActive'] == true && (data['isAdmin'] == false && data['isSuperuser'] == false))
                                    {
                                      setState(() {
                                        UserLoginData.token = data['token'].toString();
                                        UserLoginData.userId = data['userId'].toString();
                                        UserLoginData.username = data['username'].toString();
                                        UserLoginData.displayName = data['displayName'].toString();
                                        UserLoginData.email = "";
                                        UserLoginData.image = "";
                                        UserLoginData.isActive = data['isActive'].toString();
                                        UserLoginData.isSuperUser = data['isSuperuser'].toString();
                                        UserLoginData.isAdmin = data['isAdmin'].toString();
                                        UserLoginData.phone = "";
                                        UserLoginData.city = "";
                                        UserLoginData.country = "";
                                        UserLoginData.area = "";
                                        UserLoginData.postalCode = "";
                                      });
                                      validatePatient(UserLoginData.userId).then((value) => print(value));
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(snackBarError("Sorry! You don't have access."));
                                    }
                                }
                              else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarError(data['message']));
                                }
                        }
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                RichText(
                  text: TextSpan(
                      text: "Are your new here ? ",
                      style: GoogleFonts.poppins(
                          fontSize:
                          screenSize.width < tabletBreakPoint
                              ? 14
                              : 16,
                          color: kTextGray,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, "/RegisterScreen");
                            },
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: kPrimary,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
