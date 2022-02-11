
import 'package:health_care/config/data_classes.dart';

var jsonHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};

var jsonHeaderWithAuth = <String, String>{
  'Authorization': UserLoginData.token,
  'Content-Type': 'application/json',
};
