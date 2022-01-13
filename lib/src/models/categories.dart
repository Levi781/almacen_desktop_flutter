// To parse this JSON data, do
//
//     final categorias = categoriasFromMap(jsonString);

import 'dart:convert';

class Categorias {
    Categorias({
        required this.cantidad,
        required this.categorias,
    });

    int cantidad;
    List<Categoria> categorias;

    factory Categorias.fromJson(String str) => Categorias.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Categorias.fromMap(Map<String, dynamic> json) => Categorias(
        cantidad: json["cantidad"],
        categorias: List<Categoria>.from(json["categorias"].map((x) => Categoria.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cantidad": cantidad,
        "categorias": List<dynamic>.from(categorias.map((x) => x.toMap())),
    };
}

class Categoria {
    Categoria({
        this.id,
        required this.name,
        required this.user,
    });

    String? id;
    String name;
    User user;

    factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        id: json["_id"],
        name: json["name"],
        user: User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "user": user.toMap(),
    };
}

class User {
    User({
        required this.id,
    });

    String id;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
    };
}
