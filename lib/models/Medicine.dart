class Medicine{
  String medicineId;
  String medicineName;
  String description;
  Medicine({required this.medicineId, required this.medicineName, required this.description});

  factory Medicine.fromJson(dynamic json){
    return Medicine(medicineId: json['medicineId'].toString(), medicineName: json['medicineName'].toString(), description: json['description'].toString());
  }
}