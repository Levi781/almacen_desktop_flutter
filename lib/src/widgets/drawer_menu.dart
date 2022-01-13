import 'package:flutter/material.dart';

import 'menu_button.dart';
import 'menu_header.dart';

class DrawerMenu extends StatelessWidget {
  const  DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Menu',
      child:  Container(
        width: double.infinity,
        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,      
                  children: [

                    const MenuHeader(nombre: 'Jared Levi Gonzalez Ayala', usuario: 'ADMINISTRADOR'),
                    
                    const Divider(),

                    MenuButton(
                      titulo: 'Inicio', 
                      icono: Icons.home, 
                      background: Colors.blue,
                      onPressed: (){ }

                    ),

                    MenuButton(
                      titulo: 'Almacen', 
                      icono: Icons.backpack, 
                      background: Colors.blue,
                      onPressed: (){ }
                    ),

                    MenuButton(
                      titulo: 'Reportes', 
                      icono: Icons.folder,
                      background: Colors.blue,
                      onPressed: (){ }
                    ),

                    MenuButton(
                      titulo: 'Entradas/Salidas', 
                      icono: Icons.input, 
                      background: Colors.blue,
                      onPressed: (){ }
                    ),
                    
                    const Divider(),
                    const Spacer(),
                    MenuButton(titulo: 'Salir', icono: Icons.exit_to_app, onPressed: (){}, background: Colors.redAccent),
                    const SizedBox(height: 15,)

                  ],
              ),
      )
    );
  }
}