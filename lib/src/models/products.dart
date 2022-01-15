// To parse this JSON data, do
//
//     final products = productsFromMap(jsonString);

import 'dart:convert';

class Products {
    Products({
        required this.cantidad,
        required this.productos,
    });

    int cantidad;
    List<Producto> productos;

    factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Products.fromMap(Map<String, dynamic> json) => Products(
        cantidad: json["cantidad"],
        productos: List<Producto>.from(json["productos"].map((x) => Producto.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cantidad": cantidad,
        "productos": List<dynamic>.from(productos.map((x) => x.toMap())),
    };
}

class Producto {
    Producto({
        this.id,
        required this.name,
        required this.user,
        required this.serie,
        required this.category,
        required this.description,
        required this.disponible,
        this.img,
    });

    String? id;
    String name;
    String user;
    String serie;
    Category category;
    String description;
    bool disponible;
    String? img;

    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["_id"],
        name: json["name"],
        user: json["user"],
        serie: json["serie"],
        category: Category.fromMap(json["category"]),
        description: json["description"],
        disponible: json["disponible"],
        img: json["img"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "user": user,
        "serie": serie,
        "category": category.toMap(),
        "description": description,
        "disponible": disponible,
        "img": img,
    };
}

class Category {
    Category({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
    };
}
