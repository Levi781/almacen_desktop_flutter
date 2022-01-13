import 'dart:convert';

import 'package:almacen_app_flutter/src/models/categories.dart';
import 'package:almacen_app_flutter/src/models/products.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryServices extends ChangeNotifier{

  final _baseURL = baseURL+'categories';
  List<Categoria> categorias = [];
  String idCat = '';
  Categoria _currentCategory = Categoria(name: '', user: User(id: ''));

  Categoria get currentCategory => _currentCategory;

  set currentCategory(Categoria currentCategory) {
    _currentCategory = currentCategory;
    notifyListeners();
  }

  CategoryServices(){
    getAllCategories();
  }

  Future<void> getAllCategories()async{

    final res = await http.get(Uri.parse(_baseURL));

    final model = Categorias.fromJson(res.body);
    categorias = [...model.categorias];
    currentCategory = categorias[0];
    notifyListeners();
  }

  Future<bool> postCategory(String name, String uid)async{
    final res = await http.post(Uri.parse(_baseURL+'/$uid'), 
    body: jsonEncode({ "name": name, "uid": uid }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }
    );
    print(res.body);
    if( res.body.contains('msg')){
      return false;
    }else {
      getAllCategories();
      return true;
    }
  }

}