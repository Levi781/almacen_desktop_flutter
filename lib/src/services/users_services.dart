import 'dart:convert';

import 'package:almacen_app_flutter/src/models/users_data.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersServices extends ChangeNotifier{

  final _baseURL = baseURL+'users-data';
  List<User> usuariosData = [];
  User currentClientUser = User(nombre: '', apellidos: '', estado: false, puesto: '',depto: '');

  UsersServices(){
    getAllUsersDataClients();
  }

  Future<void> getAllUsersDataClients() async{
    final res = await http.get(Uri.parse(_baseURL));
    final data = UsuariosData.fromJson(res.body);
    usuariosData = [...data.users];
    currentClientUser = usuariosData[0];
    notifyListeners();
  }

  Future<bool> postUserDataClient( User user )async{

    final res = await http.post(
      Uri.parse(_baseURL),
      body: jsonEncode({
        "nombre": user.nombre,
        "apellidos": user.apellidos,
        "depto":user.depto,
        "estado":user.estado,
        "puesto":user.puesto
      }),
      headers: { 'Content-Type':'application/json; charset=UTF-8'}
    );

    if(res.body.contains('msg')){
      return false;
    }else{
      await getAllUsersDataClients();
      return true;
    }
  }


  Future<bool> putUserDataClient( User user )async{

    final res = await http.put(
      Uri.parse(_baseURL+'/${user.id}'),
      body: jsonEncode({
        "nombre": user.nombre,
        "apellidos": user.apellidos,
        "depto":user.depto,
        "estado":user.estado,
        "puesto":user.puesto
      }),
      headers: { 'Content-Type':'application/json; charset=UTF-8'}
    );

    if(res.body.contains('msg')){
      return false;
    }else{
      await getAllUsersDataClients();
      return true;
    }
  }

  Future<bool> deleteUserDataClient(String id)async{

    final res = await http.delete(Uri.parse(_baseURL+'/$id'));
    if(res.body.contains('msg')){
      return false;
    }else{
      await getAllUsersDataClients();
      return false;
    }
  }

}