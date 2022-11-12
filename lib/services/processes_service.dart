import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:rastreo_bam/models/models.dart';
import 'package:rastreo_bam/services/services.dart'
    show AuthService, HttpService;

class ProcessesService extends ChangeNotifier {
  static Future<ProcesarLD> procesarLD(idMensajero, String barra,
      [String manifiesto = '']) async {
    try {
      Map<String, dynamic> args = {
        'id_usr': await AuthService.getStorageKey('usr_id'),
        'token_usr': await AuthService.getStorageKey('usr_token'),
        'id_mensajero': idMensajero,
        'barra': barra,
        'n_manifiesto': manifiesto
      };

      final res =
          await HttpService.postData('public/api/v2/procesarLD.php', args);

      if (res == null) {
        return ProcesarLD(codigo: 500, mensaje: 'Ha ocurrido un error');
      }

      final data = ProcesarLD.fromJson(res.body);
      return data;
    } catch (e) {
      return ProcesarLD(codigo: 500, mensaje: 'Ha ocurrido un error');
    }
  }

  static Future<ProcesarLD> updateManifiesto(String manifiesto) async {
    try {
      Map<String, dynamic> args = {
        'id_usr': await AuthService.getStorageKey('usr_id'),
        'token_usr': await AuthService.getStorageKey('usr_token'),
        'n_manifiesto': manifiesto
      };

      final res = await HttpService.putData(
          'public/api/v2/update_manifiesto.php', args);

      if (res == null) {
        return ProcesarLD(codigo: 500, mensaje: 'Ha ocurrido un error');
      }

      final data = ProcesarLD.fromJson(res.body);
      return data;
    } catch (e) {
      return ProcesarLD(codigo: 500, mensaje: 'Ha ocurrido un error');
    }
  }
}
