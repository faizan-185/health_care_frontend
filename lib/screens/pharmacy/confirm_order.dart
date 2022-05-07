import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/models/MedicineOrder.dart';
import 'package:health_care/services/api_funtions/pharmacy_functions.dart';
import 'package:health_care/widgets/appbar.dart';

import '../../config/dimensions.dart';
import '../../config/styles.dart';
import '../../widgets/drawer.dart';
import '../../widgets/snackbars.dart';
import '../../widgets/verido-form-field.dart';
import '../../widgets/verido-primary-button.dart';

class ConfirmOrder extends StatefulWidget {
  List<MedicineOrder> orderList;
  String bill;
  String pharmacyId;
  ConfirmOrder({Key? key, required this.orderList, required this.bill, required this.pharmacyId}) : super(key: key);

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {

  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  Widget _header() {
    return Text("Confirm Order", style: secondaryBigHeadingTextStyle);
  }
  
  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Total Bill", style: listTileTitle,),
              Text("Rs. " + widget.bill, style: listTilePrice,)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("Enter shipment address below:", style: listTileUnit,),
          SizedBox(height: 8,),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Area",
                      style: kFormTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: areaController,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.text),
                      style: kFormTextStyle,
                      validator: textValidator,
                      decoration: veridoInputDecoration(
                          inputType: VeridoInputType.email,
                          hint: "Mughalpura"),
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
                      "City",
                      style: kFormTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: cityController,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.text),
                      style: kFormTextStyle,
                      validator: textValidator,
                      decoration: InputDecoration(
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
                        hintText: "Lahore",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Country",
                      style: kFormTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: countryController,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.text),
                      style: kFormTextStyle,
                      validator: textValidator,
                      decoration: InputDecoration(
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
                        hintText: "Pakistan",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Postal Code",
                      style: kFormTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: postalCodeController,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.number),
                      style: kFormTextStyle,
                      validator: numberValidator,
                      decoration: InputDecoration(
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
                        hintText: "12345",
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
                  width: screenSize.width,
                  child: VeridoPrimaryButton(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Confirm Order",
                          style: kPrimaryButtonTextStyle,
                        ),
                      ],
                    ),
                    onPressed: () {
                      if(_formKey.currentState?.validate() == true) {
                        setState(() {
                          status = true;
                        });
                        createOrder(widget.orderList, widget.pharmacyId, areaController.text, cityController.text, countryController.text, postalCodeController.text).then((response) {

                          setState(() {
                            status = false;
                          });
                          var data = jsonDecode(response.body);
                          if(response.statusCode==200)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess(data['message']));
                          }
                          else
                          {
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
