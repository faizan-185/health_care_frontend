import 'dart:convert';
import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/models/Doctor.dart';
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
    Uri.parse(Urls.baseUrl + Urls.getAllPatientsUrl),
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
              UserLoginData.patient_id = element.patientId;
              stat = true;
              break;
            }
        }
      }
  });
  return stat;
}

Future<bool> validateDoctor(var userId) async
{
  bool stat = false;
  await http.get(
    Uri.parse(Urls.baseUrl + Urls.getAllDoctors),
    headers: jsonHeaderWithAuth,
  ).then((response) {
    if(response.statusCode == 200)
    {
      var data = jsonDecode(response.body);
      data = data['doctor'];
      List<Doctor1> doctors = [];
      for(var element in data){
        doctors.add(Doctor1.fromJson(element));
      }
      for(var element in doctors){
        if(element.user.userId == userId)
        {
          UserLoginData.doctorId = element.doctorId;
          stat = true;
          break;
        }
      }
    }
  });
  return stat;
}