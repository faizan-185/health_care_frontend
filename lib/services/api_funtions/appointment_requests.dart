import 'package:health_care/config/data_classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';

Future<http.Response> send_request(var pid, var did, var reason) async
{
  var body = {
    "appointmentReason": reason,
    "patientId": pid,
    "doctorId": did,
    "status": "pending",
  };
  var response = await http.post(
      Uri.parse(Urls.baseUrl+Urls.sendAppointmentRequest),
      headers: jsonHeaderWithAuth,
      body: jsonEncode(body));
  return response;
}
Future<http.Response> all_appointments() async
{
  var response = await http.get(
      Uri.parse(Urls.baseUrl+Urls.getAllAppointments),
      headers: jsonHeaderWithAuth);
  return response;
}

Future<http.Response> all_appointments_of_dr() async
{
  var response = await http.get(
      Uri.parse(Urls.baseUrl+Urls.getAllAppointmentsByDr + UserLoginData.doctorId),
      headers: jsonHeaderWithAuth);
  return response;
}

Future<http.Response> accept_request(String dateTime, String appointmentId) async {
  var body = {
    "appointmentDateTime": dateTime,
    "status": "accepted"
  };
  var response = await http.patch(Uri.parse(Urls.baseUrl + Urls.acceptAppointmentRequest + appointmentId), headers: jsonHeaderWithAuth, body: jsonEncode(body));
  return response;
}

Future<http.Response> reject_request(String appointmentId) async {
  var body = {
    "appointmentDateTime": null,
    "status": "rejected"
  };
  var response = await http.patch(Uri.parse(Urls.baseUrl + Urls.acceptAppointmentRequest + appointmentId), headers: jsonHeaderWithAuth, body: jsonEncode(body));
  return response;
}