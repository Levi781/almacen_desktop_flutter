import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  const CustomButton({Key? key, 
  required this.onPressed, 
  required this.titulo, 
  required this.color, 
  }) : super(key: key);

  final Function() onPressed;
  final String titulo;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: 200,
      height: 30,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
        ),
        focusColor: Colors.red,
        child: Container(
          child: Center(child: Text( titulo, style: const TextStyle(fontSize: 15, color: Colors.white,)),),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
          ),
        ),
        onPressed: onPressed
      ),
    );
  }
}