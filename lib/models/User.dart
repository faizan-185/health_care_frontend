class User {
   String userId ;
   String username;
   String displayName;
   String email;
   String image;
   String isActive;
   String isSuperUser;
   String isAdmin;
   String phoneNumber;
   String city;
   String country;
   String area;
   String postalCode;
  String dob;
  String gender;

  User({required this.userId, required this.username, required this.displayName, required this.email,
      required this.image, required this.isActive, required this.isSuperUser, required this.isAdmin, required this.phoneNumber,
      required this.city, required this.country, required this.area, required this.postalCode, required this.dob, required this.gender});

  factory User.fromJson(dynamic json) {
    return User(
      userId: json['userId'].toString(),
      username: json['username'].toString(),
      displayName: json['displayName'].toString(),
      email: json['email'].toString(),
      image: json['image'].toString(),
      isActive: json['isActive'].toString(),
      isSuperUser: json['isSuperUser'].toString(),
      isAdmin: json['isAdmin'].toString(),
      phoneNumber: json['phoneNumber'].toString(),
      city: json['city'].toString(),
      country: json['country'].toString(),
      area: json['area'].toString(),
      postalCode: json['postalCode'].toString(),
      dob: json['dob'].toString(),
      gender: json['gender'].toString()
    );
  }
}