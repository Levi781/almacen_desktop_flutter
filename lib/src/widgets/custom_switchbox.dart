import 'package:almacen_app_flutter/src/providers/create_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSwitchBox extends StatelessWidget {
  const CustomSwitchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CreateProductProvider>(context);
    
    return SwitchListTile(
      onChanged: (value){
        productProvider.isEnabled = value;
      },
      value: productProvider.isEnabled,
      title: const Text('Disponibilidad', style: TextStyle(fontSize: 15),),
    );
  }
}