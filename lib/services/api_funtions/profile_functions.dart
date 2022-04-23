import 'package:health_care/config/data_classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';

Future<http.Response> updateProfile(var data) async
{
  var body = {
    "area": data[0],
    "city": data[1],
    "country": data[2],
    "postalCode": data[3],
    "phoneNumber": data[4]
  };
  print(body);
  print(UserLoginData.token);
  var response = await http.patch(
      Uri.parse(Urls.baseUrl+Urls.updateProfileUrl+UserLoginData.userId),
      headers: jsonHeaderWithAuth,
      body: jsonEncode(body));
  return response;
}