import 'package:flutter/material.dart';
import 'package:health_care/models/Order.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/models/MedicineOrder.dart';
import 'package:health_care/models/MedicineUnit.dart';
import 'package:health_care/models/Pharmacy.dart';
import 'package:health_care/screens/pharmacy/confirm_order.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../config/dimensions.dart';
import '../../config/light_color.dart';
import '../../config/styles.dart';
import '../../config/text_styles.dart';
import '../../services/api_funtions/pharmacy_functions.dart';
import '../../widgets/drawer.dart';
import '../../widgets/verido-primary-button.dart';

class ViewOrder extends StatefulWidget {
  Order order;
  ViewOrder({Key? key, required this.order}) : super(key: key);

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text(widget.order.pharmacy.pharmacyName, style: secondaryBigHeadingTextStyle);
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          _header(),
          Text(widget.order.pharmacy.area + " " + widget.order.pharmacy.city + " " + widget.order.pharmacy.country + ", " + widget.order.pharmacy.postalCode, style: style13500,),
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
                        UrlLauncher.launch("tel://${widget.order.pharmacy.phoneNo}");
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.order.pharmacy.phoneNo, style: listTileTitle,),
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
                        UrlLauncher.launch('mailto:${widget.order.pharmacy.email}');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(width: screenSize.width*0.4, child: Text(widget.order.pharmacy.email, style: listTileTitle,)),
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
                        String query = Uri.encodeComponent(widget.order.pharmacy.pharmacyName+" "+widget.order.pharmacy.city);
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
          Text("Ordered Meds:", style: listTilePrice,),
          SizedBox(height: 10,),
          ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: widget.order.medicineOrders.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                elevation: 3.0,
                child: ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(widget.order.medicineOrders[index].medicineUnit.medicine.medicineName + " " +widget.order.medicineOrders[index].medicineUnit.unitNumber + " " + widget.order.medicineOrders[index].medicineUnit.unit.description, style: listTileTitle,),
                  subtitle: Text("${widget.order.medicineOrders[index].quantity} x ${widget.order.medicineOrders[index].medicineUnit.pricePerUnit}", style: style13500,),
                  trailing: Text("Rs. ${int.parse(widget.order.medicineOrders[index].quantity) * double.parse(widget.order.medicineOrders[index].medicineUnit.pricePerUnit)}", style: listTilePrice,),
                ),
              );
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Total Price:", style: listTileTitle,),
              Text("Rs. ${total(widget.order.medicineOrders)}", style: listTilePrice,)
            ],
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }
}
