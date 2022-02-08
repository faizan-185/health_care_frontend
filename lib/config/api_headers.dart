
import 'package:health_care/config/data_classes.dart';

var jsonHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};

var jsonHeaderWithAuth = <String, String>{
  'x-auth-token': UserLoginData.token,
  'Content-Type': 'application/json; charset=UTF-8',
};
