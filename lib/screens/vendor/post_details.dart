import 'dart:async';
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/models/Department.dart';
import 'package:health_care/models/Hospital.dart';
import 'package:health_care/models/Post.dart';
import 'package:health_care/screens/hospital/department_details.dart';
import 'package:health_care/services/api_funtions/hospital_functions.dart';
import 'package:health_care/services/api_funtions/vendor_functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/department_card.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:health_care/widgets/snackbars.dart';
import 'package:health_care/widgets/vendor_drawer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../widgets/verido-form-field.dart';
import '../../widgets/verido-primary-button.dart';

class PostDetails extends StatefulWidget {
  Post post;
  PostDetails({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  bool status = false;
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController dateController = new TextEditingController(text: DateTime.now().toString().split(' ')[0]);
  String date = "";
  DateTime selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return SizedBox(width: screenSize.width, child: Text(widget.post.title, style: secondaryBigHeadingTextStyle));
  }
  Widget _header1() {
    return SizedBox(width: screenSize.width, child: Text(widget.post.hospital.hospitalName, style: normalBlackTitleTextStyle));
  }
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: ThirdDrawer(),
      body: status ? Center(child: CircularProgressIndicator(color: kPrimary,),) :
          ListView(
            padding: EdgeInsets.all(20),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              _header(),
              SizedBox(height: 10,),
              _header1(),
              SizedBox(height: 10,),
              Container(
                width: 100,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(Urls.baseUrl+widget.post.hospital.image),
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
                  Text("Address:", style: listTilePrice,),
                  SizedBox(
                    width: screenSize.width*0.5,
                    child: Text(widget.post.hospital.area+" "+widget.post.hospital.city+" "
                        +widget.post.hospital.country+". "+widget.post.hospital.postalCode, style: listTileTitle,),
                  ),
                ],
              ),
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
                            UrlLauncher.launch("tel://${widget.post.hospital.phoneNo}");
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(widget.post.hospital.phoneNo, style: listTileTitle,),
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
                            String query = Uri.encodeComponent(widget.post.hospital.hospitalName+" "+widget.post.hospital.city);
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
                            UrlLauncher.launch('mailto:${widget.post.hospital.email}');
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(width: screenSize.width*0.4, child: Text(widget.post.hospital.email, style: listTileTitle,)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text("Post Details", style: mainHeadingTextStyle1,),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Item:", style: listTilePrice,),
                  SizedBox(
                    width: screenSize.width*0.5,
                    child: Text(widget.post.title, style: listTileTitle,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description:", style: listTilePrice,),
                  SizedBox(
                    width: screenSize.width*0.5,
                    child: Text(widget.post.description, style: style13500,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category:", style: listTilePrice,),
                  SizedBox(
                    width: screenSize.width*0.5,
                    child: Text(widget.post.category, style: listTileTitle,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quantity:", style: listTilePrice,),
                  SizedBox(
                    width: screenSize.width*0.5,
                    child: Text(widget.post.quantity + " Items", style: listTileTitle,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Estimated Price:", style: listTilePrice,),
                  SizedBox(
                    width: screenSize.width*0.5,
                    child: Text("Rs. " + widget.post.estimatedPrice, style: listTileTitle,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Due Date:", style: listTilePrice,),
                  SizedBox(
                    width: screenSize.width*0.5,
                    child: Text(widget.post.dueDate.split('T')[0], style: listTileTitle,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Post Date:", style: listTilePrice,),
                  SizedBox(
                    width: screenSize.width*0.5,
                    child: Text(widget.post.createdAt.split('T')[0], style: listTileTitle,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text("Are you interested?", style: mainHeadingTextStyle1,),
              SizedBox(height: 5,),
              Text("Fill the following form, to get this job yours!", style: style13500,),
              SizedBox(height: 10,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.text),
                      style: kFormTextStyle,
                      validator: textValidator,
                      decoration: veridoInputDecoration(
                          inputType: VeridoInputType.text,
                          hint: "Enter Description"),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: priceController,
                      keyboardType: getKeyboardType(
                          inputType: VeridoInputType.number),
                      style: kFormTextStyle,
                      validator: numberValidator,
                      decoration: veridoInputDecoration(
                          inputType: VeridoInputType.number,
                          hint: "Enter Quote"),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      readOnly: true,
                      controller: dateController,
                      style: kFormTextStyle,
                      decoration: veridoInputDecoration(
                          inputType: VeridoInputType.text,
                          hint: "Select Your Due Date"),
                      onTap: () async {
                        await _selectDate(context);

                        setState(() {
                          dateController.text = selectedDate.toString().split(' ')[0];
                        });
                      },
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: screenSize.width,
                      child: VeridoPrimaryButton(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send Request",
                              style: kPrimaryButtonTextStyle,
                            ),
                          ],
                        ),
                        onPressed: () async {
                          if(_formKey.currentState!.validate())
                          {
                            setState(() {
                              status = true;
                            });
                            await createResponse(widget.post.postId, priceController.text, descriptionController.text, dateController.text)
                            .then((value) {

                              if(value.statusCode == 200)
                                {
                                  setState(() {
                                    status = false;
                                  });
                                  var data = jsonDecode(value.body);
                                  print(data);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess(data['message']));
                                  Timer(Duration(seconds: 2), () {
                                    Navigator.pushNamed(context, '/MyResponses');
                                  });

                                }
                              else
                                {
                                  setState(() {
                                    status = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarError("An error occurred!"));
                                }
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
    );
  }
}
