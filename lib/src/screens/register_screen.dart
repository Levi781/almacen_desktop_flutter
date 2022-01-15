import 'package:almacen_app_flutter/src/services/auth_services.dart';
import 'package:almacen_app_flutter/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();

    final authService = Provider.of<AuthServices>(context);

    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .25),
            width: double.infinity,
            //height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                const Text('CONTROL DE INVENTARIO', style: TextStyle( fontSize: 25), textAlign: TextAlign.center,),

                Container(
                  width: double.infinity,
                  height:200,
                  child: Image.asset('assets/uquifa.png')
                  //color: Colors.red,
                ),

                const Text('Crea una cuenta, sera validada por el administrador', style: TextStyle( fontSize: 25), textAlign: TextAlign.center),
      
                CustomInput(
                  icon: Icons.person,
                  labelText: 'Nombre completo',
                  controller: nameController,
                  isPasswd: false,
                ),

                CustomInput(
                  icon: Icons.email,
                  labelText: 'Correo electronico',
                  controller: emailController,
                  isPasswd: false,
                ),
      
                CustomInput(
                  icon: Icons.lock,
                  labelText: 'Credenciales',
                  controller: passwordController,
                  isPasswd: false,
                ),
      
                CustomButton(
                  color: Colors.blue,
                  titulo: 'Crear cuenta',
                  onPressed: ()async{
                    //Validar campos
                    if( emailController.text.trim().length > 3 &&  nameController.text.trim().length > 3
                     && passwordController.text.trim().length>3){
                       //Haz la peticion
                       final res = await authService.registerUser( nameController.text.trim(), emailController.text.trim(), passwordController.text.trim() );
                       if( res ){
                         await showDialog(context: context, builder: (context){
                           return const AlertDialog(
                             title: Text('Registrado'),
                             content: Text('Espera a que tu usuario sea validado'),
                           );
                         });
                          Navigator.restorablePushNamed(context, 'login');
                       }else{
                         showDialog(context: context, builder: (context){
                           return const AlertDialog(
                             title: Text('Error, habla con el admin'),
                             content: Text('Por favor dirigite con el administrador para crear tu cuenta'),
                           );
                         });
                       }
                    }

                  },
                ),

                const SizedBox(height: 20,),

                GestureDetector(
                  child: const Text('Regresar al inicio de sesión', textAlign: TextAlign.center,),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),

                const SizedBox(height: 50,),
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}