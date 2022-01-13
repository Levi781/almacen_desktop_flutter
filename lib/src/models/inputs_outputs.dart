// To parse this JSON data, do
//
//     final inputsOutputs = inputsOutputsFromMap(jsonString);

import 'dart:convert';

class InputsOutputs {
    InputsOutputs({
        required this.results,
    });

    List<Result> results;

    factory InputsOutputs.fromJson(String str) => InputsOutputs.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InputsOutputs.fromMap(Map<String, dynamic> json) => InputsOutputs(
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}

class Result {
    Result({
        required this.id,
        required this.idu,
        required this.idp,
        required this.salida,
        required this.entrada,
        required this.v,
    });

    String id;
    Idu idu;
    Idp idp;
    DateTime salida;
    String entrada;
    int v;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["_id"],
        idu: Idu.fromMap(json["idu"]),
        idp: Idp.fromMap(json["idp"]),
        salida: DateTime.parse(json["salida"]),
        entrada: json["entrada"],
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "idu": idu.toMap(),
        "idp": idp.toMap(),
        "salida": salida.toIso8601String(),
        "entrada": entrada,
        "__v": v,
    };
}

class Idp {
    Idp({
        required this.id,
        required this.name,
        required this.user,
        required this.serie,
        required this.category,
        required this.description,
        required this.disponible,
    });

    String id;
    String name;
    String user;
    String serie;
    String category;
    String description;
    bool disponible;

    factory Idp.fromJson(String str) => Idp.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Idp.fromMap(Map<String, dynamic> json) => Idp(
        id: json["_id"],
        name: json["name"],
        user: json["user"],
        serie: json["serie"],
        category: json["category"],
        description: json["description"],
        disponible: json["disponible"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "user": user,
        "serie": serie,
        "category": category,
        "description": description,
        "disponible": disponible,
    };
}

class Idu {
    Idu({
        required this.id,
        required this.nombre,
        required this.apellidos,
        required this.depto,
        required this.puesto,
        required this.estado,
        required this.v,
    });

    String id;
    String nombre;
    String apellidos;
    String depto;
    String puesto;
    bool estado;
    int v;

    factory Idu.fromJson(String str) => Idu.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Idu.fromMap(Map<String, dynamic> json) => Idu(
        id: json["_id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        depto: json["depto"],
        puesto: json["puesto"],
        estado: json["estado"],
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "depto": depto,
        "puesto": puesto,
        "estado": estado,
        "__v": v,
    };
}
