import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/Response.dart';

Future<http.Response> getAllPosts() async{
  return await http.get(Uri.parse(Urls.baseUrl + Urls.getAllPosts), headers: jsonHeaderWithAuth);
}

Future<http.Response> createResponse(String postId, String price, String description, String dueDate) async{
  var body = {
    "price": price,
    "description": description,
    "status": "pending",
    "dueDtae": dueDate,
    "postId": postId
  };
  return await http.post(
    Uri.parse(Urls.baseUrl + Urls.createResponse),
    headers: jsonHeaderWithAuth,
    body: jsonEncode(body)
  );
}

Future<List<PostResponse>> getMyResponses() async {
  late List<PostResponse> responses = [];
  late List<PostResponse> myResponses = [];
  var response = await http.get(
    Uri.parse(Urls.baseUrl + Urls.getAllResponses),
    headers: jsonHeaderWithAuth
  );
  if(response.statusCode == 200)
    {
      var data = jsonDecode(response.body)['response'] as List;
      print(data);
      responses = data.map((e) => PostResponse.fromJson(e)).toList();
      responses.forEach((element) {
        if(element.user.userId == UserLoginData.userId)
          myResponses.add(element);
      });
    }
  return myResponses;
}

