import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key, required this.titulo, required this.icono, required this.onPressed, required this.background }) : super(key: key);

  final String titulo;
  final IconData icono;
  final Function() onPressed;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        width: double.infinity,
        height: 50,
        color: background,
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Icon(icono, size: 35, color: Colors.white),
            const SizedBox(width: 10,),
            Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 20),)
          ],
        ),
      ),
      onPressed: onPressed
    );
  }


}