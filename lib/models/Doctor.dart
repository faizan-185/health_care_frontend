import 'User.dart';
class Doctor{
  late User user;
  late String doctorId;
  late String fee;
  late String experience;
  late String isAvailable;
  late String availablityDays;
  late String activeHours;
  late Specialization specialization;
  late Qualification qualification;
  Doctor({required this.user, required this.doctorId, required this.fee, required this.experience,
    required this.isAvailable, required this.availablityDays, required this.activeHours, 
    required this.specialization, required this.qualification
  });
  factory Doctor.fromJson(dynamic json){
    return Doctor(user: User.fromJson(json['User']), doctorId: json['doctorId'].toString(),
        fee: json['fee'].toString(), experience: json['experience'].toString(),
        isAvailable: json['isAvailable'].toString(), availablityDays: json['availablityDays'].toString(),
        activeHours: json['activeHours'].toString(), specialization: Specialization.fromJson(json['Specializations']),
      qualification: Qualification.fromJson(json['Qualifications'])
    );
  }
}

class Specialization{
  late String specializationId;
  late String details;
  Specialization({required this.specializationId, required this.details});
  factory Specialization.fromJson(dynamic json){
    return Specialization(specializationId: json[0]['specializationId'].toString(), details: json[0]['details']);
  }
}

class Qualification{
  late String qualificationId;
  late String details;
  Qualification({required this.qualificationId, required this.details});
  factory Qualification.fromJson(dynamic json){
    return Qualification(qualificationId: json[0]['qualificationId'].toString(), details: json[0]['details']);
  }
}


