import 'package:almacen_app_flutter/src/models/categories.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomComboBox extends StatefulWidget {

  const CustomComboBox({Key? key}) : super(key: key);

  @override
  State<CustomComboBox> createState() => _CustomComboBoxState();
}

class _CustomComboBoxState extends State<CustomComboBox> {
  @override
  Widget build(BuildContext context) {
    final categoryServices = Provider.of<CategoryServices>(context); // Instancia de provider 
    
    return  Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tipo de producto', style: TextStyle(fontSize: 17),),
                DropdownButton<Categoria>(            
                  value: categoryServices.currentCategory,
                  borderRadius: BorderRadius.circular(20),
                  underline: Container(),
                  onChanged: (newValue) {
                     categoryServices.currentCategory = newValue!;
                  },
                  items: <Categoria>[...categoryServices.categorias]
                      .map<DropdownMenuItem<Categoria>>((Categoria value) {
                    return DropdownMenuItem<Categoria>(
                      value: value,
                      child: Text(value.name, style: const TextStyle(fontSize: 17),),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}