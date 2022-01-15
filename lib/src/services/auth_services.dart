
import 'dart:convert';

import 'package:almacen_app_flutter/src/models/users.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier{
  
  List<Usuario> usuariosRoles = [];
  late  Usuario user;
  final _baseURL = baseURL+'auth';

  AuthServices(){
    getAllUsers();
  }

  Future<bool> inicioDeSesion(String email, String passw)async{
    final res = await http.post(Uri.parse(_baseURL), 
    body: jsonEncode({ "email": email, "password": passw }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }
    );
    if( res.body.contains('msg')){
      return false;
    }else if(res.body.contains('uid')){
      user = Usuario.fromJson(res.body);
      return true;
    }
    return false;
  }

  Future<bool> registerUser( String nombre, String email, String password  )async{

    final res = await http.post(
      Uri.parse(baseURL+'users'), 
      body: jsonEncode({
        "nombre": nombre,
        "email": email,
        "password": password,
        "role": "USER_ROLE",
        "username": DateTime.now().toString()
        },
      ),

      headers: {'Content-Type':"application/json; charset=UTF-8"}
    );

    String response = '';
    response = jsonDecode(res.body).toString();

    if( response.contains('error')){
      return false;
    }
    return true;
  }


  Future getAllUsers()async{
    final users = await http.get(Uri.parse(baseURL+'users'));

    final res = Usuarios.fromJson( users.body );
    usuariosRoles = [ ...res.usuarios];
    notifyListeners();
  }

  Future activateUser( Usuario userActive, bool estado )async{
    final res = await http.put(
      Uri.parse(baseURL+'users/${userActive.uid}'),
      body: jsonEncode({
        "estado": estado
      }),
      headers: {'Content-Type':"application/json; charset=UTF-8"}
    );
    print(res.body);
    getAllUsers();
  }

  Future deleteUser( Usuario userDelete )async{
    final res = await http.delete(Uri.parse(baseURL+'users/${userDelete.uid}'),
    headers: { 'Content-Type': 'application/json; charset=UTF-8'});
    print(res);
    getAllUsers();
  }


}