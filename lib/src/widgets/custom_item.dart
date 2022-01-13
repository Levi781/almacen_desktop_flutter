import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String label;
  final Color color;
  final Color backcolor;
  final Function()? onPressed;
  final IconData icon;

  const CustomItem({
    Key? key, 
    required this.label, 
    required this.onPressed, 
    required this.color,
    required this.backcolor,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
          color: backcolor,
          borderRadius: BorderRadius.circular(10)
          ),
          child: MaterialButton(
            child: Row(
              children: [
                Icon( icon , color: color,),
                const SizedBox(width: 10,),
                Text( label, style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold)),
              ],
            ),
            onPressed: onPressed,
          ),
        ),
        Container(width: double.infinity, height:1, color:Colors.white)
      ],
    );
  }
}