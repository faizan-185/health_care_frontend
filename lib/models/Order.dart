import 'package:health_care/models/MedicineOrder.dart';
import 'package:health_care/models/Pharmacy.dart';
import 'package:health_care/models/User.dart';

class Order{
  String orderId;
  String area;
  String city;
  String country;
  String postalCode;
  String status;
  bool isPaid;
  String dateTime;
  User user;
  Pharmacy pharmacy;
  List<MedicineOrders> medicineOrders;
  Order({required this.orderId, required this.area, required this.city, required this.country,
    required this.postalCode, required this.status, required this.isPaid, required this.dateTime, required this.user, required this.pharmacy, required this.medicineOrders});

  factory Order.fromJson(dynamic json){
    var l = json['MedicineOrders'] as List;
    List<MedicineOrders> ll = l.map((e) => MedicineOrders.fromJson(e)).toList();
    return Order(
      orderId: json['orderId'].toString(),
      area: json['area'].toString(),
      city: json['city'].toString(),
      country: json['country'].toString(),
      postalCode: json['postalCode'].toString(),
      status: json['status'].toString(),
      isPaid: json['isPaid'],
      dateTime: json['createdAt'],
      user: User.fromJson(json['User']),
      pharmacy: Pharmacy.fromJson(json['Pharmacy']),
      medicineOrders: ll
    );
  }
}