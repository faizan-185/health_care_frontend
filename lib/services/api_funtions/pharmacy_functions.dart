import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/urls.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getAllPharmacies() async
{
  var response = await http.get(Uri.parse(Urls.baseUrl+Urls.getAllPharmacies), headers: jsonHeaderWithAuth);
  return response;
}