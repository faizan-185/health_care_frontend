import 'package:health_care/models/Hospital.dart';
import 'package:health_care/models/User.dart';

class Post{
  String postId;
  String title;
  String description;
  String category;
  String quantity;
  String estimatedPrice;
  String status;
  String dueDate;
  String hospitalAdminId;
  String createdAt;
  User user;
  Hospital hospital;
  Post({
    required this.postId,
    required this.title,
    required this.description,
    required this.category,
    required this.quantity,
    required this.estimatedPrice,
    required this.dueDate,
    required this.status,
    required this.createdAt,
    required this.hospitalAdminId,
    required this.user,
    required this.hospital
});

  factory Post.fromJson(dynamic json)
  {
    return Post(
      postId: json['postId'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      category: json['category'].toString(),
      quantity: json['quantity'].toString(),
      estimatedPrice: json['estimatedPrice'].toString(),
      dueDate: json['dueDtae'].toString(),
      status: json['status'].toString(),
      createdAt: json['createdAt'].toString(),
      hospitalAdminId: json['hospitalAdminId'].toString(),
      user: User.fromJson(json['User']),
      hospital: Hospital.fromJson(json['User']['Hospitals'][0]),
    );
  }
}