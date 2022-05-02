import 'package:health_care/models/User.dart';

class Pharmacy{
  String pharmacyId;
  String pharmacyName;
  String area;
  String city;
  String country;
  String postalCode;
  String licenseNumber;
  String phoneNo;
  String email;
  String adminId;
  User user;

  Pharmacy({required this.pharmacyId, required this.pharmacyName, required this.area, required this.city, required this.country, required this.postalCode,
              required this.licenseNumber, required this.phoneNo, required this.email, required this.adminId, required this.user});

  factory Pharmacy.fromJson(dynamic json){
    return Pharmacy(
        pharmacyId: json['pharmacyId'].toString(),
        pharmacyName: json['pharmacyName'].toString(),
        area: json['area'].toString(),
        city: json['city'].toString(),
        country: json['country'].toString(),
        postalCode: json['postalCode'].toString(),
        licenseNumber: json['licenseNumber'].toString(),
        phoneNo: json['phoneNo'].toString(),
        email: json['email'].toString(),
        adminId: json['adminId'].toString(),
        user: User.fromJson(json['User']));
  }
}