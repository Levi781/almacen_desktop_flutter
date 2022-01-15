import 'package:almacen_app_flutter/src/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivateUsersScreen extends StatelessWidget {
  const ActivateUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authServices = Provider.of<AuthServices>(context);

    return Scaffold(
      body: Container(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemCount: authServices.usuariosRoles.length,
          itemBuilder: (context, indice){
            final usuario = authServices.usuariosRoles[indice];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                title: Text('Nombre: ${usuario.nombre}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                subtitle: Text('Correo electronico: ${usuario.email}'),
                trailing: Container(
                  width: 250,
                  height: 100,
                  child: Row(
                    children: [
                      if(usuario.estado == false)
                        TextButton(
                          child: const Text('Eliminar'),
                          onPressed: (){
                            authServices.deleteUser( usuario );
                          }, 
                        ),
                      
                      if(usuario.estado == false)
                      TextButton(
                        child: const Text('Activar'),
                        onPressed: (){
                          // Acticar al usuario
                          authServices.activateUser(usuario, true);
                        }, 
                      ),
                      if(usuario.estado)
                      TextButton(
                        child: const Text('Desactivar'),
                        onPressed: (){
                          // Acticar al usuario
                          authServices.activateUser(usuario, false);
                        }, 
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        )
      )
    );
  }
}