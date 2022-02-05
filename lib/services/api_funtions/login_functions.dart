import 'dart:convert';
import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;
Future<http.Response> login(var email, var password) async
{
  var body = {
    "email": email,
    "password": password
  };
  var response = await http.post(
      Uri.parse(Urls.baseUrl+Urls.loginUrl),
      headers: jsonHeader,
      body: jsonEncode(body));
  return response;
}