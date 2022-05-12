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
  late var diseases;
  Doctor({required this.user, required this.doctorId, required this.fee, required this.experience,
    required this.isAvailable, required this.availablityDays, required this.activeHours, 
    required this.specialization, required this.qualification, required this.diseases
  });
  factory Doctor.fromJson(dynamic json){
    var data = json['DiseaseTreatedByDrs'];
    var data1 = data.map((e) => DiseaseTreatedByDr.fromJson(e)).toList();
    return Doctor(user: User.fromJson(json['User']), doctorId: json['doctorId'].toString(),
        fee: json['fee'].toString(), experience: json['experience'].toString(),
        isAvailable: json['isAvailable'].toString(), availablityDays: json['availablityDays'].toString(),
        activeHours: json['activeHours'].toString(), specialization: Specialization.fromJson(json['Specializations']),
      qualification: Qualification.fromJson(json['Qualifications']),
        diseases: data1
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

class Disease{
  late String diseaseId;
  late String diseaseName;
  late String diseaseDescription;
  late String diseaseSymptoms;
  late String diseaseCauses;
  late String diseaseType;
  late String riskFactor;
  Disease({required this.diseaseId, required this.diseaseName, required this.diseaseDescription,
    required this.diseaseSymptoms, required this.diseaseCauses ,required this.diseaseType,
    required this.riskFactor
  });
  factory Disease.fromJson(dynamic json){
    return Disease(diseaseId: json['diseaseId'].toString(), diseaseName: json['diseaseName'].toString(),
        diseaseDescription: json['diseaseDescription'].toString(), diseaseSymptoms: json['diseaseSymptoms'].toString(),
        diseaseCauses: json['diseaseCauses'].toString(), diseaseType: json['diseaseType'].toString(),
        riskFactor: json['riskFactor'].toString());
  }
}

class DiseaseTreatedByDr{
  late String dtbdId;
  late Disease disease;
  DiseaseTreatedByDr({required this.dtbdId, required this.disease});
  factory DiseaseTreatedByDr.fromJson(dynamic json){
    return DiseaseTreatedByDr(dtbdId: json['dtbdId'].toString(), disease: Disease.fromJson(json['Disease']));
  }
}

class Doctor1{
  late User user;
  late String doctorId;
  late String fee;
  late String experience;
  late String isAvailable;
  late String availablityDays;
  late String activeHours;
  Doctor1({required this.user, required this.doctorId, required this.fee, required this.experience,
    required this.isAvailable, required this.availablityDays, required this.activeHours
  });
  factory Doctor1.fromJson(dynamic json){
    return Doctor1(user: User.fromJson(json['User']), doctorId: json['doctorId'].toString(),
        fee: json['fee'].toString(), experience: json['experience'].toString(),
        isAvailable: json['isAvailable'].toString(), availablityDays: json['availablityDays'].toString(),
        activeHours: json['activeHours'].toString()
    );
  }
}