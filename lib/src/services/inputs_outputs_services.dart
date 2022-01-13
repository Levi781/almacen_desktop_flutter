
import 'dart:convert';

import 'package:almacen_app_flutter/src/models/inputs_outputs.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InputOutputsServices extends ChangeNotifier{

  final _baseURL = baseURL+'inputs';
  List<Result> inputsOutputs = [];

  InputOutputsServices(){
    getAllInputsOutputs();
  }
  

  Future<void> getAllInputsOutputs()async{
    final res = await http.get(Uri.parse(_baseURL));
    final data = InputsOutputs.fromJson( res.body );
    inputsOutputs = [...data.results];
    notifyListeners();
  }


  Future<bool> postRegisterInput(String idu, String idp)async{

    final fecha = DateTime.now().toString();
    final res = await http.post(
      Uri.parse(_baseURL),
      body: jsonEncode({
        "idu": idu,
        "idp": idp,
        "salida": fecha
      }),
      headers: { 'Content-Type': 'application/json; charset=UTF-8', }
    );

    if(res.body.contains('msg')){
      return false;
    }else{
      await getAllInputsOutputs();
      return true;
    }
  }

  Future<bool> putRegisterInput(String id,String idu, String idp)async{

    final entrada = DateTime.now().toString();
    final res = await http.put(
      Uri.parse(_baseURL+'/$id'),
      body: jsonEncode({
        "idu": idu,
        "idp": idp,
        "entrada": entrada
      }),
      headers: { 'Content-Type': 'application/json; charset=UTF-8', }
    );

    if(res.body.contains('msg')){
      return false;
    }else{
      await getAllInputsOutputs();
      return true;
    }
  }

}