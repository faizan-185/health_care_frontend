import 'package:flutter/material.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/models/Doctor.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/drawer.dart';

class DiseaseDetails extends StatefulWidget {
  Disease disease;
  DiseaseDetails({Key? key, required this.disease}) : super(key: key);

  @override
  _DiseaseDetailsState createState() => _DiseaseDetailsState();
}

class _DiseaseDetailsState extends State<DiseaseDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return SizedBox(width: screenSize.width, child: Text(widget.disease.diseaseName, style: secondaryBigHeadingTextStyle));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackground,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          SizedBox(
            height: 20,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Description:", style: listTilePrice,),
              SizedBox(
                width: screenSize.width*0.5,
                child: Text(widget.disease.diseaseDescription, style: listTileTitle,)
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Symptoms:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                width: screenSize.width*0.5,
                child: Text(widget.disease.diseaseSymptoms, style: listTileTitle,)
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Causes:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                  width: screenSize.width*0.5,
                  child: Text(widget.disease.diseaseCauses, style: listTileTitle,)
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Disease Type:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                  width: screenSize.width*0.5,
                  child: Text(widget.disease.diseaseSymptoms, style: listTileTitle,)
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Risk Factor:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                  width: screenSize.width*0.5,
                  child: Text(widget.disease.riskFactor, style: listTileTitle,)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
