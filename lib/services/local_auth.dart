import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future validateIs() async {
    // final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    // final bool canAuthenticate =
    //     canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

    // print('canAuthenticateWithBiometrics $canAuthenticateWithBiometrics');
    // print('canAuthenticateWithBiometrics $canAuthenticate');
    return;
  }
}
