import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:almacen_app_flutter/src/models/products.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';

class ProductsService extends ChangeNotifier{

  final _baseURl = baseURL+'products';
  List<Producto> productos = [];
  List<Producto> noproductos = [];
  List<Producto> siproductos = [];

  Producto _currentProduct =  Producto(name: '', user: '', serie: '', category: Category(id: '', name: ''), description: '', disponible: false);

  Producto get currentProduct => _currentProduct;

  set currentProduct(Producto currentProduct) {
    _currentProduct = currentProduct;
    notifyListeners();
  }

  ProductsService(){
    getProducts();
    getNoProducts();
    getSiProducts();
  }

  Future getProducts() async{
    final res = await http.get(Uri.parse(_baseURl));
    final model = Products.fromJson(res.body);
    productos = [...model.productos];
    notifyListeners();
  }
  Future getNoProducts() async{
    final res = await http.get(Uri.parse(_baseURl+'/not'));
    final model = Products.fromJson(res.body);
    noproductos = [...model.productos];
    notifyListeners();
  }
  Future getSiProducts() async{
    final res = await http.get(Uri.parse(_baseURl+'/available'));
    final model = Products.fromJson(res.body);
    siproductos = [...model.productos];
    notifyListeners();
  }

  Future<bool> postProduct( Producto producto, File? file)async{
    //Cargar imagen primero
    String img = '';
    if( file != null){
       final image = http.MultipartRequest("POST", Uri.parse(baseURL+'uploads'));
        image.files.add( await http.MultipartFile.fromPath('archivo', file.path ));
        http.StreamedResponse response = await image.send();
        final data = await http.Response.fromStream(response);
        img = jsonDecode( data.body )['nombre'];
    }


    final res = await http.post(
      Uri.parse(_baseURl), 
      body: jsonEncode(
        {
           "idc": producto.category.id,
           "idu": producto.user,
           "name": producto.name,
           "serie": producto.serie,
           "description": producto.description,
           "disponible": producto.disponible,
           "img": img
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


  Future<bool> putProduct( Producto producto, File? file)async{
     String img = '';
    if( file != null){
       final image = http.MultipartRequest("POST", Uri.parse(baseURL+'uploads'));
        image.files.add( await http.MultipartFile.fromPath('archivo', file.path ));
        http.StreamedResponse response = await image.send();
        final data = await http.Response.fromStream(response);
        img = jsonDecode( data.body )['nombre'];
    }

    final res = await http.put(
      Uri.parse(_baseURl+'/${producto.id}'),
      body: jsonEncode({
        "idc": producto.category.id,
        "idu": producto.user,
        "name": producto.name,
        "serie": producto.serie,
        "description": producto.description,
        "disponible": producto.disponible,
        "img": img
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