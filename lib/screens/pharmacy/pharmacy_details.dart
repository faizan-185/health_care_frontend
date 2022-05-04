import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/models/MedicineOrder.dart';
import 'package:health_care/models/MedicineUnit.dart';
import 'package:health_care/models/Pharmacy.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../config/dimensions.dart';
import '../../config/light_color.dart';
import '../../config/styles.dart';
import '../../config/text_styles.dart';
import '../../services/api_funtions/pharmacy_functions.dart';

class PharmacyDetails extends StatefulWidget {
  Pharmacy pharmacy;
  PharmacyDetails({Key? key, required this.pharmacy}) : super(key: key);

  @override
  State<PharmacyDetails> createState() => _PharmacyDetailsState();
}

class _PharmacyDetailsState extends State<PharmacyDetails> {
  List<MedicineUnit> medicines = [];
  List<MedicineUnit> bucket = [];
  List<MedicineOrder> orderList = [];
  List<MedicineUnit> filteredMedicines = [];
  bool show = false;
  void getMeds() async
  {
    setState(() {
      status = true;
    });
    await getAllMedicinesOfPharmacy(widget.pharmacy.pharmacyId).then((response) {
      var data = jsonDecode(response.body)['medicinePharmacy'] as List;
      setState(() {
        medicines = data.map((med) => MedicineUnit.fromJson(med['MedicineUnit'])).toList();
        status = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getMeds();
  }

  bool status = false;
  double bucketHeight = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text(widget.pharmacy.pharmacyName, style: secondaryBigHeadingTextStyle);
  }
  Widget _searchField() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Ex: Panadol CF",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: Icon(Icons.search, color: kPrimary)
                  .alignCenter
                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
        onChanged: (String? text){
          if(text!.isEmpty)
            {
              setState(() {
                show = false;
              });
            }
          else{
            setState(() {
              filteredMedicines.clear();
              medicines.forEach((element) {
                if (element.medicine.medicineName.toLowerCase().contains(text.toLowerCase()))
                  {
                    filteredMedicines.add(element);
                  }
              });
              show = true;
            });
          }
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
        key: _scaffoldKey,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      body: ListView(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          _header(),
          Text(widget.pharmacy.area + " " + widget.pharmacy.city + " " + widget.pharmacy.country + ", " + widget.pharmacy.postalCode, style: style13500,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Call us at:", style: listTilePrice,),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.phone, color: kPrimary, size: 15),
                      onPressed: (){
                        UrlLauncher.launch("tel://${widget.pharmacy.phoneNo}");
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.pharmacy.phoneNo, style: listTileTitle,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email us at:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.at, color: kPrimary, size: 15),
                      onPressed: (){
                        UrlLauncher.launch('mailto:${widget.pharmacy.email}');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(width: screenSize.width*0.4, child: Text(widget.pharmacy.email, style: listTileTitle,)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reach to us:", style: listTilePrice,),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.mapMarkedAlt, color: kPrimary, size: 15),
                      onPressed: (){
                        String query = Uri.encodeComponent(widget.pharmacy.pharmacyName+" "+widget.pharmacy.city);
                        String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
                        UrlLauncher.launch(googleUrl);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Open Map", style: listTileTitle,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text("Order your Meds:", style: listTilePrice,),
          SizedBox(height: 10,),
          medicines.length == 0 ? Container(
            width: screenSize.width,
            height: 50,
            child: Center(child: Text("Sorry, No medicines are available now!", style: TextStyle(color: Colors.red),)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: kGeneralWhite,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 8,
                  color: Colors.grey.withOpacity(0.8),
                )
              ],
            ),
          ) :
          Container(
            padding: EdgeInsets.all(10),
            width: screenSize.width,
            height: bucket.length == 0 ? 50 : bucketHeight,
            child: bucket.length == 0 ? Center(child: Text("Empty Bucket! Search your meds below.")) : ListView.builder(
              itemCount: bucket.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  child: ListTile(
                    title: Text(bucket[index].medicine.medicineName),
                  ),
                );
              },
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: kGeneralWhite,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 8,
                  color: Colors.grey.withOpacity(0.8),
                )
              ],
            ),
          ),
          SizedBox(height: 15,),
          Text("Search your meds here:", style: style13500,),
          SizedBox(height: 5,),
          _searchField(),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: filteredMedicines.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: ListTile(
                  title: Text(filteredMedicines[index].medicine.medicineName, style: listTileTitle,),
                  subtitle: Text(filteredMedicines[index].medicine.description, style: style13500,),
                  trailing: Text("Rs. " + filteredMedicines[index].pricePerUnit, style: listTilePrice,),
                  onTap: (){
                    setState(() {
                      bucket.add(filteredMedicines[index]);
                      bucketHeight += 78;
                    });
                  },
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
