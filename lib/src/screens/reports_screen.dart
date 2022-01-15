import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              child: const  Text('GENERADOR DE REPORTES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: ListView(
                children: [
                  CustomButton(onPressed: (){
                    final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                    navegationModel.paginaActual = 11;
                  }, titulo: 'Historial completo', color: Colors.deepPurple),
                  CustomButton(onPressed: (){
                    final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                    navegationModel.paginaActual = 12;
                  }, titulo: 'Sin entregar', color: Colors.deepPurple),
                  CustomButton(onPressed: (){
                    final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                    navegationModel.paginaActual = 13;
                  }, titulo: 'Disponible', color: Colors.deepPurple),
                ],
              )
            ),
          ],
        )
      )
    );
  }
}