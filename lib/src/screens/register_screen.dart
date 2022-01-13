import 'package:almacen_app_flutter/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();

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
                  onPressed: (){
                    Navigator.restorablePushNamed(context, 'dashboard');
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