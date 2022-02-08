import 'User.dart';

class Patient {
  String patientId ;
  String status;
  User user;

  Patient({required this.patientId, required this.status, required this.user});

  factory Patient.fromJson(dynamic json) {
    return Patient(
        patientId: json['patientId'].toString(),
        status: json['status'].toString(),
        user: User.fromJson(json['User']),
    );
  }
}