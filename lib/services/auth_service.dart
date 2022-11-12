import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:rastreo_bam/models/models.dart' show User;
import 'package:rastreo_bam/services/services.dart' show HttpService;

class AuthService extends ChangeNotifier {
  static const _storage = FlutterSecureStorage();

  static Future<String?> login(String username, String password) async {
    try {
      Map<String, dynamic> args = {
        'usr_cod': username,
        'pass': password,
        'version': '0.0.1'
      };

      final res = await HttpService.postData('public/api/v2/login.php', args);

      if (res == null) return 'Ha ocurrido un error al momento iniciar sesión';

      final data = User.fromJson(res.body);
      final String mensaje = data.mensaje ?? '';

      if (data.token != null && data.token!.isNotEmpty) {
        await _storage.write(key: 'usr_token', value: data.token);
        await _storage.write(key: 'usr_id', value: data.idUsr);
        await _storage.write(key: 'usr_cod', value: data.usrCod);
        await _storage.write(key: 'usr_nombre', value: data.usrNombre);
        return null;
      } else {
        return mensaje;
      }
    } catch (e) {
      return 'Ha ocurrido un error al momento iniciar sesión';
    }
  }

  static Future logout() async {
    await _storage.deleteAll();
    return;
  }

  static Future<String> readToken() async {
    // return await _storage.read(key: 'token') ?? '';
    return 'ec53d41df13d8cc718c3d4cd7d471d1a5e100e9e77b1b77493bd0da253ee5069';
  }

  static Future<Map<String, String>> readUserInfo() async {
    Map<String, String> userInfo = {
      'usr_cod': await _storage.read(key: 'usr_cod') ?? '',
      'usr_nombre': await _storage.read(key: 'usr_nombre') ?? '',
    };
    return userInfo;
  }

  static Future<dynamic> getStorageKey(String key) async {
    if (key == 'usr_token') {
      return 'ec53d41df13d8cc718c3d4cd7d471d1a5e100e9e77b1b77493bd0da253ee5069';
    }
    return await _storage.read(key: key) ?? '';
  }
}
