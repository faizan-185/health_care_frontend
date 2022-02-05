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