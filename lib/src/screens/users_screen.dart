
import 'package:almacen_app_flutter/src/models/users_data.dart';
import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:almacen_app_flutter/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersServices = Provider.of<UsersServices>(context);
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  CustomButton(onPressed: (){
                    usersServices.currentClientUser = User(
                      nombre: '', apellidos: '', estado: false, puesto: '',depto: ''
                    );

                    final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                    navegationModel.paginaActual = 8;

                  }, titulo: 'Agregar usuario', color: Colors.deepPurple)
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('USUARIOS EN EL SISTEMA', style: TextStyle(fontSize: 25),),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usersServices.usuariosData.length,
                itemBuilder: (context, indice){
                  return CardUser( user: usersServices.usuariosData[indice],);
                }
              )
            )
          ],
        ),
      )
    );
  }
}