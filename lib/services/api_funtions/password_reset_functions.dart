
import 'dart:convert';

import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;

void getUser(var email){

}

Future<http.Response> sendEmail({required String subject, required String to, required String name, required String code}) async{
  var body = json.encode({
    "service_id": "service_pl61qyh",
    "template_id": "template_0b3zix4",
    "user_id": "user_F3AXhMpqbwDzN9EkPtSHE",
    "accessToken": "fe9bfb50ca1fa5b205fdae331ce62622",
    "template_params": {
      "to_name": name,
      "subject": subject,
      "code": code,
      "to_email": to
    }
  });
  var response  = await http.post(Uri.parse(Urls.sendEmailUrl), body: body, headers: jsonHeader);
  return response;
}