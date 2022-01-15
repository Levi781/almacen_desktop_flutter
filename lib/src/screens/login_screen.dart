import 'package:almacen_app_flutter/src/services/auth_services.dart';
import 'package:almacen_app_flutter/src/widgets/custom_button.dart';
import 'package:almacen_app_flutter/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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

                //TODO: Agregar imagen 

                Container(
                  width: double.infinity,
                  height:200,
                  child: Image.asset('assets/uquifa.png')
                  //color: Colors.red,
                ),

                const Text('Inicia Sesión para continuar', style: TextStyle( fontSize: 25), textAlign: TextAlign.center),
      
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
                  isPasswd: true,
                ),
      
                CustomButton(
                  color: Colors.blue,
                  titulo: 'Iniciar sesión',
                  onPressed: ()async{
                    final authService = Provider.of<AuthServices>(context, listen:false);
                    bool isLogin = await authService.inicioDeSesion(emailController.text, passwordController.text);
                    if( isLogin ){
                      Navigator.restorablePushNamed(context, 'home');
                    }else{
                      showDialog(
                        context: context, 
                        builder: (context){
                          return const AlertDialog(
                            title: Text('Verifica tus credenciales por favor'),
                          );
                        }
                      );
                    }
                  },
                ),

                const SizedBox(height: 20,),

                GestureDetector(
                  child: const Text('¿Necesitas crear una cuenta?\nPresiona aquí', textAlign: TextAlign.center,),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, 'register');
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