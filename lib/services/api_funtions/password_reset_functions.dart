
import 'dart:convert';

import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;

Future<bool> getUser(var email) async {
  var response = await http.get(Uri.parse(Urls.baseUrl+Urls.getUserByEmailUrl+email));
  var data = jsonDecode(response.body);
  if(response.statusCode==200 && data['user']!=null) {
    UserLoginData.userId = data['user']['userId'].toString();
    UserLoginData.email = email;
    UserLoginData.displayName = data['user']['displayName'];
    return true;
  }
  else
    return false;
}

Future<String> getUserName(var email) async {
  var response = await http.get(Uri.parse(Urls.baseUrl+Urls.getUserByEmailUrl+email));
  var data = jsonDecode(response.body);
  if(response.statusCode==200 && data['user']!=null) {
    return data['user']['displayName'];
  }
  else
    return "";
}

Future<http.Response> sendEmail({required String subject, required String to, required String name, required String message}) async{
  var body = json.encode({
    "service_id": "service_0qpoe7j",
    "template_id": "template_i6dvx4s",
    "user_id": "x_vtIV3LkihKRnkwR",
    "accessToken": "ttbn8YimKrQ6_4OOKv5W6",
    "template_params": {
      "to_name": name,
      "to_email": to,
      "subject": subject,
      "message": message,
      "user_email": to
    }
  });
  var response  = await http.post(Uri.parse(Urls.sendEmailUrl), body: body, headers: jsonHeader);
  return response;
}

Future<http.Response> resetPassword(String userId, String password) async {
  var body = {
    "userId": userId,
    "password": password
  };
  var response = await http.post(Uri.parse(Urls.baseUrl+Urls.resetPasswordUrl), body: jsonEncode(body), headers: jsonHeader);
  return response;
}