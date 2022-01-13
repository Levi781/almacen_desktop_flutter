// To parse this JSON data, do
//
//     final usuarios = usuariosFromMap(jsonString);

import 'dart:convert';

class Usuarios {
    Usuarios({
        required this.total,
        required this.usuarios,
    });

    int total;
    List<Usuario> usuarios;

    factory Usuarios.fromJson(String str) => Usuarios.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuarios.fromMap(Map<String, dynamic> json) => Usuarios(
        total: json["total"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toMap())),
    };
}

class Usuario {
    Usuario({
        required this.nombre,
        required this.username,
        required this.email,
        required this.password,
        required this.estado,
        required this.role,
        this.uid,
    });

    String nombre;
    String username;
    String email;
    String password;
    bool estado;
    String role;
    String? uid;

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        estado: json["estado"],
        role: json["role"],
        uid: json["uid"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "username": username,
        "email": email,
        "password": password,
        "estado": estado,
        "role": role,
        "uid": uid,
    };
}
