import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/services/api_funtions/password_reset_functions.dart';
import 'package:health_care/widgets/snackbars.dart';
import 'package:health_care/widgets/verido-form-field.dart';
import 'package:health_care/widgets/verido-primary-button.dart';

class SendEmail extends StatefulWidget {
  const SendEmail({Key? key}) : super(key: key);

  @override
  _SendEmailState createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        iconTheme: IconThemeData(
          color: kPrimary
        ),
      ),
      backgroundColor: kBackground,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: screenSize.height*0.02,),
          Text("Reset Password", style: bigHeadingPrimaryTextStyle,),
          SizedBox(
            height: screenSize.height*0.01,
          ),
          Text("Enter your email to get a 4-digit code.", style: style14500grey,),
          SizedBox(
            height: 5,
          ),
          Text("If you did not receive an email then check spam.", style: detailHeadings,),
          SizedBox(
            height: screenSize.height*0.05,
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
                          "Send Email",
                          style: kPrimaryButtonTextStyle,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      if(_formKey.currentState?.validate() == true) {
                        var rng = Random();
                        var rand = rng.nextInt(9000) + 1000;
                        setState(() {
                          progress = true;
                          UserLoginData.code = rand.toString();
                        });
                        await getUser(_emailController.text).then((value) async {
                          if(value==true)
                            {
                              await sendEmail(subject: "Recover Password", to: _emailController.text, name: UserLoginData.displayName, code: UserLoginData.code).then((value) {
                                if(value.statusCode==200)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess("Email has been sent to you!"));
                                  Navigator.pushNamed(context, "/OtpScreen");
                                }
                                else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarError("Sorry! An error occurred."));
                                }
                              });
                            }
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(snackBarError("Sorry! Can't find your email."));
                            }
                        });

                        setState(() {
                          progress = false;
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
