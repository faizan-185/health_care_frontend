import 'package:health_care/models/MedicineUnit.dart';

class MedicineOrder{
  int muId;
  MedicineUnit medicineUnit;
  int quantity;
  MedicineOrder({required this.muId, required this.quantity, required this.medicineUnit});
  Map<String, int> toJson() => {
    'muId': muId,
    'quantity': quantity,
  };
}