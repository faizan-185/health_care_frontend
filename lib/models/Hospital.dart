class Hospital {
  String hospitalId ;
  String hospitalName;
  String openingHours;
  String image;
  String phoneNo;
  String city;
  String country;
  String area;
  String postalCode;
  String email;

  Hospital({required this.hospitalId, required this.hospitalName, required this.openingHours, required this.email,
    required this.image, required this.phoneNo,
    required this.city, required this.country, required this.area, required this.postalCode});

  factory Hospital.fromJson(dynamic json) {
    return Hospital(
        hospitalId: json['hospitalId'].toString(),
        hospitalName: json['hospitalName'].toString(),
        openingHours: json['openingHours'].toString(),
        email: json['email'].toString(),
        image: json['image'].toString(),
        phoneNo: json['phoneNo'].toString(),
        city: json['city'].toString(),
        country: json['country'].toString(),
        area: json['area'].toString(),
        postalCode: json['postalCode'].toString(),
    );
  }
}