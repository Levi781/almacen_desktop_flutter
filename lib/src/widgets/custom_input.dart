import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {


  CustomInput({Key? key, required this.labelText, required this.icon, required this.isPasswd, required this.controller}) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  bool isPasswd = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        maxLines: 1,
        obscureText: isPasswd,
      ),
    );
  }
}