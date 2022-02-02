import 'dart:io';

import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class VeridoBiometrics {
  VeridoBiometrics._();

  factory VeridoBiometrics() => _instance;

  static final VeridoBiometrics _instance = VeridoBiometrics._();

  var localAuth = LocalAuthentication();

  bool _initialized = false;
  late bool canCheckBiometrics;
  late List<BiometricType> availableBiometrics;
  late bool usesFaceID;

  static const iosStrings = const IOSAuthMessages(
      cancelButton: 'cancel',
      goToSettingsButton: 'settings',
      goToSettingsDescription: 'Please set up your Touch ID.',
      lockOut: 'Please re-enable your Touch ID');

  static const androidStrings = const AndroidAuthMessages(
    cancelButton: "cancel",
    goToSettingsButton: "settings",
    goToSettingsDescription: "Please set up your Biometric ID",
  );

  Future<bool> authenticate({String? reason}) async {
    return await localAuth.authenticate(
      localizedReason:
          reason == null ? 'Biometric authentication is required' : reason,
      useErrorDialogs: false,
      iOSAuthStrings: iosStrings,
      androidAuthStrings: androidStrings,
    );
  }

  Future<void> init() async {
    if (!_initialized) {
      print("starting biometric initialization");
      canCheckBiometrics = await localAuth.canCheckBiometrics;
      availableBiometrics = await localAuth.getAvailableBiometrics();
      _initialized = true;
      print(canCheckBiometrics);
      print(availableBiometrics);

      canCheckBiometrics = availableBiometrics.isNotEmpty;

      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          usesFaceID = true;
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          usesFaceID = false;
        }
      } else {
        usesFaceID = false;
      }
      print("done");

      return;
    } else {
      return;
    }
  }
}

// var localAuth = LocalAuthentication();
