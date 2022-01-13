import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:almacen_app_flutter/src/models/products.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';

class ProductsService extends ChangeNotifier{

  final _baseURl = baseURL+'products';
  List<Producto> productos = [];
  Producto _currentProduct =  Producto(name: '', user: '', serie: '', category: Category(id: '', name: ''), description: '', disponible: false);

  Producto get currentProduct => _currentProduct;

  set currentProduct(Producto currentProduct) {
    _currentProduct = currentProduct;
    notifyListeners();
  }

  ProductsService(){
    getProducts();
  }

  Future getProducts() async{
    final res = await http.get(Uri.parse(_baseURl));
    final model = Products.fromJson(res.body);
    productos = [...model.productos];
    notifyListeners();
  }

  Future<bool> postProduct( Producto producto )async{
    final res = await http.post(
      Uri.parse(_baseURl), 
      body: jsonEncode(
        {
           "idc": producto.category.id,
           "idu": producto.user,
           "name": producto.name,
           "serie": producto.serie,
           "description": producto.description,
           "disponible": producto.disponible
         }
      ),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(res.body.contains('msg')){
      return false;
    }else{
      await getProducts();
      return true;
    }
  }


  Future<bool> putProduct( Producto producto)async{

    final res = await http.put(
      Uri.parse(_baseURl+'/${producto.id}'),
      body: jsonEncode({
        "idc": producto.category.id,
        "idu": producto.user,
        "name": producto.name,
        "serie": producto.serie,
        "description": producto.description,
        "disponible": producto.disponible
      }),
      headers: {'Content-Type':'application/json; charset=UTF-8'}
    );
    
    if(res.body.contains('msg')){
      return false;
    }else{
      await getProducts();
      return true;
    }

  }


  Future<bool> deleteProduct( String idProduct, String idUser )async{

    final res = await http.delete(
      Uri.parse(_baseURl+'/$idProduct/$idUser'),
      headers: { 'Content-Type': 'application/json; charset=UTF-8' }
    );

    if(res.body.contains('msg')){
      return false;
    }else{
      getProducts();
      return true;
    }
  }


}