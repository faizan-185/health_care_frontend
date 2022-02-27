import 'package:health_care/models/Hospital.dart';

class Department {
  String departmentId ;
  String departmentName;
  String image;
  String email;
  String phoneNo;
  Hospital hospital;

  Department({required this.departmentId, required this.departmentName, required this.email,
    required this.image, required this.phoneNo, required this.hospital});

  factory Department.fromJson(dynamic json) {
    return Department(
      departmentId: json['departmentId'].toString(),
      departmentName: json['departmentName'].toString(),
      email: json['email'].toString(),
      image: json['image'].toString(),
      phoneNo: json['phoneNo'].toString(),
      hospital: Hospital.fromJson(json['Hospital'])
    );
  }
}

class Department1 {
  String departmentId ;
  String departmentName;
  String image;
  String email;
  String phoneNo;

  Department1({required this.departmentId, required this.departmentName, required this.email,
    required this.image, required this.phoneNo});

  factory Department1.fromJson(dynamic json) {
    return Department1(
        departmentId: json['departmentId'].toString(),
        departmentName: json['departmentName'].toString(),
        email: json['email'].toString(),
        image: json['image'].toString(),
        phoneNo: json['phoneNo'].toString()
    );
  }
}