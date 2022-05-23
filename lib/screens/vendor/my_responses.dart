import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/models/Response.dart';
import 'package:health_care/services/api_funtions/vendor_functions.dart';
import 'package:health_care/widgets/vendor_drawer.dart';

import '../../config/styles.dart';
import '../../widgets/appbar.dart';

class MyResponses extends StatefulWidget {
  const MyResponses({Key? key}) : super(key: key);

  @override
  State<MyResponses> createState() => _MyResponsesState();
}

class _MyResponsesState extends State<MyResponses> {
  List<PostResponse> pending = [];
  List<PostResponse> rejected = [];
  List<PostResponse> accepted = [];

  void getResponses() async {
    setState(() {
      status = true;
    });
    await getMyResponses().then((value) {
      setState(() {
        status = false;
        value.forEach((element) {
          if(element.status.toLowerCase() == "pending") {
            pending.add(element);
          }
          else if(element.status.toLowerCase() == "rejected"){
            rejected.add(element);}
          else{
            accepted.add(element);
          }
        });
      });
    });
  }

  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text("My Responses", style: secondaryBigHeadingTextStyle);
  }
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getResponses();
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
              <Widget>[
                pending.length==0 ? Text("No Pending Responses!", style: TextStyle(color: Colors.red),) : ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: pending.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 3.0,
                        child: ListTile(title: Text(pending[index].description, style: listTileTitle,),
                          trailing: Text("Rs. " + pending[index].price, style: listTilePrice,),
                          isThreeLine: true,
                          subtitle: Column(
                            children: [
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("To: ", style: listTilePrice,),
                                    Text(pending[index].post.hospital.hospitalName, style: style13500,)
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Offered Date: ", style: listTilePrice,),
                                    Text(pending[index].dueDate.split('T')[0], style: style13500,)
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Response Date: ", style: listTilePrice,),
                                    Text(pending[index].createdAt.split('T')[0], style: style13500,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                rejected.length==0 ? Text("No Rejected Responses!", style: TextStyle(color: Colors.red),) : ListView.builder(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: rejected.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 3.0,
                        color: kRedLight,
                        child: ListTile(title: Text(rejected[index].description, style: listTileTitle,),
                          trailing: Text("Rs. " + rejected[index].price, style: listTilePrice,),
                          isThreeLine: true,
                          subtitle: Column(
                            children: [
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("To: ", style: listTilePrice,),
                                    Text(rejected[index].post.hospital.hospitalName, style: style13500,)
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Offered Date: ", style: listTilePrice,),
                                    Text(rejected[index].dueDate.split('T')[0], style: style13500,)
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Response Date: ", style: listTilePrice,),
                                    Text(rejected[index].createdAt.split('T')[0], style: style13500,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                accepted.length==0 ? Text("No Accepted Responses!", style: TextStyle(color: Colors.red),) : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    reverse: true,
                    physics: ScrollPhysics(),
                    itemCount: accepted.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 3.0,
                        color: kGreenLight,
                        child: ListTile(title: Text(accepted[index].description, style: listTileTitle,),
                          trailing: Text("Rs. " + accepted[index].price, style: listTilePrice,),
                          isThreeLine: true,
                          subtitle: Column(
                            children: [
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("To: ", style: listTilePrice,),
                                    Text(accepted[index].post.hospital.hospitalName, style: style13500,)
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Offered Date: ", style: listTilePrice,),
                                    Text(accepted[index].dueDate.split('T')[0], style: style13500,)
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Response Date: ", style: listTilePrice,),
                                    Text(accepted[index].createdAt.split('T')[0], style: style13500,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ].elementAt(_selectedIndex),
            ],
          ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.exclamation),
            label: 'Pending',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Rejected',
            backgroundColor: kPrimary,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.check),
            label: 'Accepted',
            backgroundColor: kPrimary,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimary,
        onTap: _onItemTapped,
      ),
    );
  }
}
