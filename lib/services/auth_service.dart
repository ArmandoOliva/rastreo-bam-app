import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:rastreo_bam/models/models.dart';
import 'package:rastreo_bam/services/http_service.dart';

class AuthService extends ChangeNotifier {
  static const storage = FlutterSecureStorage();

  static Future<String?> login(String username, String password) async {
    try {
      Map<String, dynamic> args = {
        'usr_cod': username,
        'pass': password,
        'version': '0.0.1'
      };

      final res = await HttpService.postData('public/api_ae/login.php', args);

      if (res == null) return 'Ha ocurrido un error al momento iniciar sesión';

      final data = User.fromJson(res.body);
      final String mensaje = data.mensaje ?? '';

      if (data.token != null && data.token!.isNotEmpty) {
        await storage.write(key: 'token', value: data.token);
        return null;
      } else {
        return mensaje;
      }
    } catch (e) {
      return 'Ha ocurrido un error al momento iniciar sesión';
    }
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
