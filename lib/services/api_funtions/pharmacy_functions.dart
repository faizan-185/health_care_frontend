import 'dart:convert';

import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;

import '../../models/MedicineOrder.dart';
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

Future<http.Response> createOrder(List<MedicineOrder> orderList, String pharmacyId, String area, String city, String country, String postalCode) async
{
  var data = {
    "pharmacyId": pharmacyId,
    "area": area,
    "city": city,
    "country": country,
    "postalCode": postalCode,
    "status": "pending",
    "isPaid": false,
    "medicine": orderList
  };
  var response = await http.post(Uri.parse(Urls.baseUrl + Urls.createOrder), headers: jsonHeaderWithAuth, body: jsonEncode(data));
  return response;
}