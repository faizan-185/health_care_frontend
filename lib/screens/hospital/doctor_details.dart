import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/models/Doctor.dart';
import 'package:health_care/screens/hospital/disease_details.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:health_care/widgets/verido-primary-button.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DoctorDetails extends StatefulWidget {
  Doctor doctor;
  DoctorDetails({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool status = false;
  bool notFound = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return SizedBox(width: screenSize.width, child: Text(widget.doctor.user.displayName, style: secondaryBigHeadingTextStyle));
  }
  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
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
          widget.doctor.isAvailable == "true" ? Text("Available Now", style: TextStyle(color: kPrimary),) : Text("Not Available Now.", style: TextStyle(color: Colors.red)),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(Urls.baseUrl+widget.doctor.user.image),
                  fit: BoxFit.fill
              ),
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Call me at:", style: listTilePrice,),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.phone, color: kPrimary, size: 15),
                      onPressed: (){
                        UrlLauncher.launch("tel://${widget.doctor.user.phoneNumber}");
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.doctor.user.phoneNumber, style: listTileTitle,),
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
              Text("Email me at:", style: listTilePrice,),
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
                        UrlLauncher.launch('mailto:${widget.doctor.user.email}');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(width: screenSize.width*0.4, child: Text(widget.doctor.user.email, style: listTileTitle,)),
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
              Text("Fee:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  children: [
                    Text(widget.doctor.fee, style: detailData2,),
                    SizedBox(width: 5,),
                    Text("PKR", style: listTileTitle,)
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
              Text("Experience:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                width: screenSize.width*0.5,
                child: Row(
                  children: [
                    Text(widget.doctor.experience, style: detailData2,),
                    SizedBox(width: 5,),
                    Text("Years", style: listTileTitle,)
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
              Text("Availability:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                width: screenSize.width*0.5,
                child: Text(widget.doctor.availablityDays + " - " + widget.doctor.activeHours, style: listTileTitle,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Specialization:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                width: screenSize.width*0.5,
                child: Text(widget.doctor.specialization.details, style: listTileTitle,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Qualification:", style: listTilePrice,),
              Spacer(),
              SizedBox(
                width: screenSize.width*0.5,
                child: Text(widget.doctor.qualification.details, style: listTileTitle,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          SizedBox(
            width: screenSize.width*0.5,
            child: VeridoPrimaryButton(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Send Request For Appointment",
                    style: kPrimaryButtonTextStyle,
                  ),
                ],
              ),
              onPressed: () {

              },
            ),
          ),
          SizedBox(height: 10,),
          Text("Diseases Treated By Doctor:", style: listTilePrice,),
          SizedBox(height: 10,),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: widget.doctor.diseases.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                elevation: 2,
                child: ListTile(
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => DiseaseDetails(disease: widget.doctor.diseases[index].disease)));
                  },
                  leading: Text("${index+1}",),
                  title: Text(widget.doctor.diseases[index].disease.diseaseName, style: listTileTitle,),
                  subtitle: Text(widget.doctor.diseases[index].disease.diseaseDescription, style: style13500,),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
