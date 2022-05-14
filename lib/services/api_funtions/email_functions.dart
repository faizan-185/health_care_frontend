
import 'dart:convert';

import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;
var user_email = "";
var name = "";
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

Future<bool> findUser(var email) async {
  var response = await http.get(Uri.parse(Urls.baseUrl+Urls.getUserByEmailUrl+email));
  var data = jsonDecode(response.body);
  if(response.statusCode==200 && data['user']!=null) {
    user_email = email;
    name = data['user']['displayName'];
    return true;
  }
  else
    return false;
}

Future<http.Response> sendAppointmentEmail({required String subject, required String to, required String name, required String type}) async{
  var body = json.encode({
    "service_id": "service_pl61qyh",
    "template_id": "template_0b3zix4",
    "user_id": "user_F3AXhMpqbwDzN9EkPtSHE",
    "accessToken": "fe9bfb50ca1fa5b205fdae331ce62622",
    "template_params": {
      "to_name": name,
      "subject": subject,
      "to_email": to
    }
  });
  var response  = await http.post(Uri.parse(Urls.sendEmailUrl), body: body, headers: jsonHeader);
  return response;
}
