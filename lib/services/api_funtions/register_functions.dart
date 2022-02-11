import 'package:health_care/config/data_classes.dart';
import 'package:health_care/services/api_funtions/login_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';

Future<http.Response> register(var name, var email, var password) async
{
  var body = {
    "displayName": name,
    "email": email,
    "password": password,
    "isAdmin": "0",
    "isSuperuser": "0",
  };
  var response = await http.post(
      Uri.parse(Urls.baseUrl+Urls.registerUrl),
      headers: jsonHeader,
      body: jsonEncode(body));
  return response;
}

Future<http.Response> registerPatient(var email, var password) async
{
  var id;
  await login(email, password).then((value) {
    var data = jsonDecode(value.body);
    UserLoginData.token = data['token'].toString();
    id = data['user']['userId'].toString();
  });
  var body = {
      "status": "Recently Registered",
      "userId": id,
  };
  print(body);
  var response = await http.post(
      Uri.parse(Urls.baseUrl+Urls.createPatientUrl),
      headers: jsonHeaderWithAuth,
      body: jsonEncode(body));
  return response;
}