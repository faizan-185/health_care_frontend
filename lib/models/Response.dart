import 'package:health_care/models/Post.dart';
import 'package:health_care/models/User.dart';

class PostResponse{
  String responseId;
  String price;
  String description;
  String status;
  String dueDate;
  String createdAt;
  User user;
  Post post;

  PostResponse({required this.responseId, required this.price, required this.description, required this.status, required this.dueDate, required this.createdAt, required this.user, required this.post});

  factory PostResponse.fromJson(dynamic json)
  {
    return PostResponse(
      responseId: json['responseId'].toString(),
      price: json['price'].toString(),
      description: json['description'].toString(),
      status: json['status'].toString(),
      dueDate: json['dueDtae'].toString(),
      createdAt: json['createdAt'].toString(),
      user: User.fromJson(json['User']),
      post: Post.fromJson(json['Post'])
    );
  }
}