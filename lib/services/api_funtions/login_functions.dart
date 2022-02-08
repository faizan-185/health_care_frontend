import 'dart:convert';
import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/models/Patient.dart';
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

Future<bool> validatePatient(var userId) async {
  bool stat = false;
  await http.get(
    Uri.parse(Urls.baseUrl + Urls.getAllPatients),
    headers: jsonHeaderWithAuth,
  ).then((response) {
    if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        data = data['patient'];
        List<Patient> patients = [];
        for(var element in data){
          patients.add(Patient.fromJson(element));
        }
        for(var element in patients){
          if(element.user.userId == userId)
            {
              stat = true;
              break;
            }
        }
      }
  });
  return stat;
}