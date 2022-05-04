import 'package:health_care/models/Medicine.dart';
import 'package:health_care/models/Unit.dart';

class MedicineUnit{
  String muId;
  String unitNumber;
  String pricePerUnit;
  Medicine medicine;
  Unit unit;
  MedicineUnit({required this.muId, required this.unitNumber, required this.pricePerUnit, required this.medicine, required this.unit});
  factory MedicineUnit.fromJson(dynamic json){
    return MedicineUnit(muId: json['muId'].toString(), unitNumber: json['unitNumber'].toString(), pricePerUnit: json['pricePerUnit'].toString(), medicine: Medicine.fromJson(json['Medicine']), unit: Unit.fromJson(json['Unit']));
  }
}