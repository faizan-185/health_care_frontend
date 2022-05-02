import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/models/Pharmacy.dart';
import 'package:health_care/services/api_funtions/pharmacy_functions.dart';
import 'package:health_care/widgets/pharmacy_card.dart';

import '../../config/light_color.dart';
import '../../config/styles.dart';
import '../../config/text_styles.dart';
import '../../widgets/appbar.dart';
import '../../widgets/drawer.dart';

class AllPharmacies extends StatefulWidget {
  const AllPharmacies({Key? key}) : super(key: key);

  @override
  State<AllPharmacies> createState() => _AllPharmaciesState();
}

class _AllPharmaciesState extends State<AllPharmacies> {

  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Pharmacy> pharmacies = [];
  Widget _header() {
    return Text("All Pharmacies", style: secondaryBigHeadingTextStyle).p16;
  }
  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          hintText: "Search",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: Icon(Icons.search, color: kPrimary)
                  .alignCenter
                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
      ),
    );
  }

  void getAllPharmaciesData()
  {
    setState(() {
      status = true;
    });
    getAllPharmacies()
        .then((response){
            var data = jsonDecode(response.body)['pharmacy'] as List;
            setState(() {
              pharmacies = data.map((pharmacy) => Pharmacy.fromJson(pharmacy)).toList();
              status = false;
              print(pharmacies[0].pharmacyName);
            });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllPharmaciesData();
  }

  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackground,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          _searchField(),
          SizedBox(height: 10,),
          Container(
            height: screenSize.height - 230,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: pharmacies.length,
              itemBuilder: (BuildContext context, int index){
                return PharmacyCard(pharmacy: pharmacies[index]);
              }
            ),
          )
        ],
      ),
    );
  }
}
