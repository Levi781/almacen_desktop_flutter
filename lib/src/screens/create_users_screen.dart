import 'package:almacen_app_flutter/src/models/users_data.dart';
import 'package:almacen_app_flutter/src/providers/providers.dart';
import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:almacen_app_flutter/src/widgets/custom_button.dart';
import 'package:almacen_app_flutter/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateUsersScreen extends StatelessWidget {
  CreateUsersScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final lastController = TextEditingController();
  final deptoController = TextEditingController();
  final puestController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final usersServices = Provider.of<UsersServices>(context);
    nameController.text = usersServices.currentClientUser.nombre;
    lastController.text = usersServices.currentClientUser.apellidos;
    deptoController.text = usersServices.currentClientUser.depto;
    puestController.text = usersServices.currentClientUser.puesto;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(right: 100, left:100),
                children: [
                  SizedBox(width: 200,height: 40,
                    child: Align(child: 
                      Row(
                        children: [
                          IconButton(
                            focusColor: Colors.deepPurple,
                            onPressed: (){
                              final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                              navegationModel.paginaActual = 6;
                            }, 
                            icon: const Icon(Icons.arrow_back)),
                          const Text('Regresar')
                        ],
                      ), 
                    alignment: Alignment.centerLeft,),
                  ) ,
                  const Text('Crear un nuevo usuario', style: TextStyle(fontSize: 25),),
                  const SizedBox(height: 25,),
                  CustomInput(labelText: 'Nombre(s)', icon: Icons.person, isPasswd: false, controller: nameController),
                  CustomInput(labelText: 'Apellidos', icon: Icons.person, isPasswd: false, controller: lastController),
                  CustomInput(labelText: 'Departamento', icon: Icons.person, isPasswd: false, controller: deptoController),
                  CustomInput(labelText: 'Puesto', icon: Icons.person, isPasswd: false, controller: puestController),
                  const CustomSwitchBoxUser(),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomButton(onPressed: ()async{

                      final usersProvider = Provider.of<CreateUsersProvider>(context, listen: false);
                      if( usersServices.currentClientUser.id != null ){

                        final newClient = User(
                          id: usersServices.currentClientUser.id,
                          nombre: nameController.text,
                          apellidos: lastController.text,
                          depto: deptoController.text,
                          puesto: puestController.text,
                          estado: usersProvider.isEnabled,
                        );

                        final res = await usersServices.putUserDataClient(newClient);
                        if(res){
                          print('Exito');
                        }else{
                          print('Frcaso');
                        }

                      }else{

                        final newClient = User(
                          nombre: nameController.text,
                          apellidos: lastController.text,
                          depto: deptoController.text,
                          puesto: puestController.text,
                          estado: usersProvider.isEnabled,
                        );

                        final res = await usersServices.postUserDataClient(newClient);
                        if(res){
                          print('Exito');
                        }else{
                          print('Frcaso');
                        }
                      }


                    }, titulo: 'Crear usuario', color: Colors.deepPurple),
                  )
                ]
              ),
            )
          ],
        ),
      )
    );
  }
}

class CustomSwitchBoxUser extends StatelessWidget {
  const CustomSwitchBoxUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<CreateUsersProvider>(context);
    
    return SwitchListTile(
      onChanged: (value){
        usersProvider.isEnabled = value;
      },
      value: usersProvider.isEnabled,
      title: const Text('Habilitado', style: TextStyle(fontSize: 15),),
    );
  }
}