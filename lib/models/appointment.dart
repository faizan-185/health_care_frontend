import 'package:health_care/models/Patient.dart';

import 'User.dart';

class Appointment {
  String appointmentId ;
  String appointmentDateTime;
  String appointmentReason;
  String fee;
  String status;
  String dateTime;
  Patient patient;
  DoctorAppointment doctor;

  Appointment({required this.appointmentId, required this.appointmentDateTime, required this.appointmentReason,
    required this.fee, required this.status, required this.dateTime, required this.patient, required this.doctor});

  factory Appointment.fromJson(dynamic json) {
    return Appointment(
        appointmentId: json['appointmentId'].toString(),
        appointmentDateTime: json['appointmentDateTime'] ?? "",
        appointmentReason: json['appointmentReason'].toString(),
        fee: json['fee'].toString(),
        status: json['status'].toString(),
        dateTime: json['createdAt'].toString().split('T').join(' At ').split('.')[0],
        patient: Patient.fromJson(json['Patient']),
        doctor: DoctorAppointment.fromJson(json['Doctor'])
    );
  }
}

class DoctorAppointment{
  String doctorId;
  User user;
  DoctorAppointment({required this.doctorId, required this.user});
  factory DoctorAppointment.fromJson(dynamic json){
    return DoctorAppointment(user: User.fromJson(json['User']), doctorId: json['doctorId'].toString(),
    );
  }
}