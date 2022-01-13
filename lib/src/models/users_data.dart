// To parse this JSON data, do
//
//     final usuariosData = usuariosDataFromMap(jsonString);

import 'dart:convert';

class UsuariosData {
    UsuariosData({
        required this.ok,
        required this.users,
    });

    bool ok;
    List<User> users;

    factory UsuariosData.fromJson(String str) => UsuariosData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuariosData.fromMap(Map<String, dynamic> json) => UsuariosData(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toMap())),
    };
}

class User {
    User({
        this.id,
        required this.nombre,
        required this.apellidos,
        required this.depto,
        required this.puesto,
        required this.estado,
    });

    String? id;
    String nombre;
    String apellidos;
    String depto;
    String puesto;
    bool estado;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        depto: json["depto"],
        puesto: json["puesto"],
        estado: json["estado"]
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "depto": depto,
        "puesto": puesto,
        "estado": estado
    };
}
