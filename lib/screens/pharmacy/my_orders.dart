import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/models/MedicineOrder.dart';
import 'package:health_care/models/Order.dart';
import 'package:health_care/screens/pharmacy/view_order.dart';
import 'package:health_care/services/api_funtions/pharmacy_functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/drawer.dart';

import '../../config/dimensions.dart';
import '../../config/styles.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  List<Order> orders = [];
  List<Order> pending = [];
  List<Order> rejected = [];
  List<Order> accepted = [];

  void getMyOrders() async {
    setState(() {
      status = true;
    });
    await getAllOrders().then((response) {
      setState(() {
        status = false;
      });
      if (response.statusCode == 200)
        {
          setState(() {
            var data = jsonDecode(response.body)['order'] as List;
            orders = data.map((e) => Order.fromJson(e)).toList();
            orders.forEach((element) {
              if(element.status == 'pending')
                pending.add(element);
              else if (element.status == 'rejected')
                rejected.add(element);
              else if(element.status == 'accepted')
                accepted.add(element);
            });
          });
        }
    });
  }

  @override
  void initState() {
    super.initState();
    getMyOrders();
  }

  bool status = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text("My Orders", style: secondaryBigHeadingTextStyle);
  }
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  String dateTimeGet(String dateTime)
  {
    return dateTime.split('T')[0] + " - " + dateTime.split('T')[1].split('.')[0];
  }
  String total(List<MedicineOrders> l)
  {
    var s = 0.0;
    l.forEach((element) {
      s = s + (int.parse(element.quantity) * double.parse(element.medicineUnit.pricePerUnit));
    });
    return s.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        padding: EdgeInsets.only(left: 16, right: 16),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 20,),
          _header(),
          SizedBox(height: 15,),
          <Widget>[
            pending.length==0 ? Text("No Pending Orders!", style: TextStyle(color: Colors.red),) : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: pending.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3.0,
                      child: ListTile(
                        leading: Text((index + 1).toString()),
                        title: Text(pending[index].pharmacy.pharmacyName, style: listTileTitle,),
                        subtitle: Text(dateTimeGet(pending[index].dateTime), style: style13500,),
                        trailing: Text("Rs. " + total(pending[index].medicineOrders), style: listTilePrice,),
                        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => ViewOrder(order: pending[index]))),
                      )
                  );
                }),
            rejected.length==0 ? Text("No Rejected Orders!", style: TextStyle(color: Colors.red),) : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: rejected.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: kRedLight,
                    elevation: 3.0,
                    child: ListTile(

                      leading: Text((index + 1).toString()),
                      title: Text(rejected[index].pharmacy.pharmacyName, style: listTileTitle,),
                      subtitle: Text(dateTimeGet(rejected[index].dateTime), style: style13500,),
                      trailing: Text("Rs. " + total(rejected[index].medicineOrders), style: listTilePrice,),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => ViewOrder(order: rejected[index]))),
                    ),
                  );
                }),
            accepted.length==0 ? Text("No Accepted Orders!", style: TextStyle(color: Colors.red),) : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: accepted.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: kGreenLight,
                    elevation: 3.0,
                    child: ListTile(
                      isThreeLine: true,
                      leading: Text((index + 1).toString()),
                      title: Text(accepted[index].pharmacy.pharmacyName, style: listTileTitle,),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dateTimeGet(accepted[index].dateTime), style: style13500,),
                          accepted[index].isPaid ? Text("Delivered", style: style12400Green,) : Text("In Progress", style: style12400Orange,)
                        ],
                      ),
                      trailing: Text("Rs. " + total(accepted[index].medicineOrders), style: listTilePrice,),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => ViewOrder(order: accepted[index]))),
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
