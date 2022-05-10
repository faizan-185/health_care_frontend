import 'package:health_care/models/MedicineUnit.dart';

class MedicineOrder{
  int muId;
  MedicineUnit medicineUnit;
  int quantity;
  MedicineOrder({required this.muId, required this.quantity, required this.medicineUnit});
  Map<String, dynamic> toJson() => {
    'muId': muId,
    'quantity': quantity,
  };
}

class MedicineOrders{
  String moId;
  MedicineUnit medicineUnit;
  String quantity;
  MedicineOrders({required this.moId, required this.quantity, required this.medicineUnit});
  factory MedicineOrders.fromJson(dynamic json)
  {
    return MedicineOrders(moId: json['moId'].toString(), quantity: json['quantity'].toString(), medicineUnit: MedicineUnit.fromJson(json['MedicineUnit']));
  }
}