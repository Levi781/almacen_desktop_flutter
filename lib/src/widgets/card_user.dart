import 'package:almacen_app_flutter/src/models/users_data.dart';
import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardUser extends StatelessWidget {

  final User user;

  const CardUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Card(
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20 ),
        child: Column(
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nombre de usuario'),
                  Text(user.nombre + ' '+ user.apellidos),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Area: ${user.depto}'),
                  Text('ID: ${user.id}'),
                ],
              ),
              leading: CircleAvatar(
                child: Text( user.nombre[0] ),
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: ()async{
                        
                        final usersServices = Provider.of<UsersServices>(context, listen: false);
                        await usersServices.deleteUserDataClient(user.id!);

                      }, 
                    ),

                    const SizedBox(width: 20,),

                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: (){
                        final usersServices = Provider.of<UsersServices>(context, listen: false);
                        usersServices.currentClientUser = user;
                        final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                        navegationModel.paginaActual = 8;
                      },
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}