import 'package:health_care/models/Department.dart';
import 'package:health_care/models/Doctor.dart';
class DrInDepart{
  late Doctor doctor;
  late Department1 department;
  late String drInDepartId;
  DrInDepart({required this.drInDepartId, required this.department, required this.doctor,
  });
  factory DrInDepart.fromJson(dynamic json){
    return DrInDepart(drInDepartId: json['drInDepartId'].toString(),
        department: Department1.fromJson(json['Department']),
        doctor: Doctor.fromJson(json['Doctor']),
    );
  }
}