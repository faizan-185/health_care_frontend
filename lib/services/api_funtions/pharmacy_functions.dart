import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;

import '../../models/MedicineUnit.dart';

Future<http.Response> getAllPharmacies() async
{
  var response = await http.get(Uri.parse(Urls.baseUrl+Urls.getAllPharmacies), headers: jsonHeaderWithAuth);
  return response;
}

Future<http.Response> getAllMedicinesOfPharmacy(var id) async{
  var response = await http.get(Uri.parse(Urls.baseUrl+Urls.getAllMedicineInPharmacyByPharmacy+id), headers: jsonHeaderWithAuth);
  return response;
}

