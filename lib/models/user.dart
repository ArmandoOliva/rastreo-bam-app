import 'dart:convert';

class User {
  int? codigo;
  String? mensaje;
  String? idUsr;
  String? usrCod;
  String? usrNombre;
  String? token;

  User({
    this.usrCod,
    this.codigo,
    this.mensaje,
    this.idUsr,
    this.usrNombre,
    this.token,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) => User(
        codigo: json["codigo"],
        mensaje: json["mensaje"],
        idUsr: json["id_usr"],
        usrCod: json["usr_cod"],
        usrNombre: json["usr_nombre"],
        token: json["token"],
      );
}
