import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getAllHospitals() async
{
  var response = await http.get(
      Uri.parse(Urls.baseUrl+Urls.getAllHospitalsUrl),
      headers: jsonHeaderWithAuth);
  return response;
}

Future<http.Response> getAllDepartments() async
{
  var response = await http.get(
      Uri.parse(Urls.baseUrl+Urls.getAllDepartments),
      headers: jsonHeaderWithAuth);
  return response;
}

Future<http.Response> getAllDoctorsOfDepartment(var id) async
{
  var response = await http.get(
      Uri.parse(Urls.baseUrl+Urls.getAllDoctorsInDepartment+id),
      headers: jsonHeaderWithAuth);
  return response;
}