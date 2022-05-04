class Unit{
  String unitId;
  String description;
  Unit({required this.unitId,required this.description});
  factory Unit.fromJson(dynamic json){
    return Unit(unitId: json['unitId'].toString(), description: json['description'].toString());
  }
}