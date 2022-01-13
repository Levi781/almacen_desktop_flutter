
import 'dart:convert';

import 'package:almacen_app_flutter/src/models/users.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier{
  
  late  Usuario user;
  final _baseURL = baseURL+'auth';

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


}