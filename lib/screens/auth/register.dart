import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/widgets/verido-form-field.dart';
import 'package:health_care/widgets/verido-primary-button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  Icon _passwordSuffix = Icon(
    CupertinoIcons.eye,
    size: 16,
    color: kPrimary,
  );
  bool _passwordHide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(
            height: screenSize.height*0.1,
          ),
          Text(
            "Register Now",
            style: secondaryBigHeadingTextStyle,
          ),
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
                      "Full Name",
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
                          hint: "abcd xyz"),
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
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: screenSize.width*0.5,
                  child: VeridoPrimaryButton(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: kPrimaryButtonTextStyle,
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                RichText(
                  text: TextSpan(
                      text: "Already a user ? ",
                      style: GoogleFonts.poppins(
                          fontSize:
                          screenSize.width < tabletBreakPoint
                              ? 14
                              : 16,
                          color: kTextGray,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, "/LoginScreen");
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
