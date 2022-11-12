import 'dart:convert';

class ProcesarLD {
  int codigo;
  String mensaje;
  int? individual;
  String? nManifiesto;

  ProcesarLD({
    required this.codigo,
    required this.mensaje,
    this.individual,
    this.nManifiesto,
  });

  factory ProcesarLD.fromJson(String str) =>
      ProcesarLD.fromMap(json.decode(str));

  factory ProcesarLD.fromMap(Map<String, dynamic> json) => ProcesarLD(
        codigo: json["codigo"],
        mensaje: json["mensaje"],
        individual: json["individual"],
        nManifiesto: json["n_manifiesto"],
      );
}
