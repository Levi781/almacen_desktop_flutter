import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    Key? key,
    required this.nombre,
    required this.usuario
  }) : super(key: key);

  final String nombre;
  final String usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    height: 240,
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Image(
                            image: AssetImage('assets/uquifa.png'),
                            fit: BoxFit.cover,
                          ),
                          
                        ),
                        const SizedBox(height: 10,),
                        const Text('Control de inventario interno', style: TextStyle(fontSize: 25,), textAlign: TextAlign.center,),
                        const SizedBox(height: 10,),
                        Text( nombre ),
                        Text( usuario )
                      ],
                    ),
                  );
  }
}