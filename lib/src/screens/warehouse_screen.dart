import 'package:almacen_app_flutter/src/models/products.dart';
import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/auth_services.dart';
import 'package:almacen_app_flutter/src/services/products_services.dart';
import 'package:almacen_app_flutter/src/widgets/card_product.dart';
import 'package:almacen_app_flutter/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WarehouseScreen extends StatelessWidget {
  const WarehouseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 100,
            child: Row(
              children: [
                
                CustomButton(
                  titulo: 'Agregar producto',
                  color: Colors.deepPurple,
                  onPressed: (){
                    productsService.currentProduct = Producto(
                      name: '', 
                      user: Provider.of<AuthServices>(context, listen:false).user.uid.toString(), 
                      serie: '', 
                      category: Category(id: '0', name: ''), 
                      description: '', 
                      disponible: true
                    );

                    final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                    navegationModel.paginaActual = 5;
                  },
                ),
                CustomButton(
                  titulo: 'Agregar categoria',
                  color: Colors.red[300]!,
                  onPressed: (){
                    final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                    navegationModel.paginaActual = 7;
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              semanticChildCount: 4,
              itemCount: productsService.productos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:  4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, indice){
                final producto = productsService.productos[indice];
                return CardProduct( producto: producto );
              }
            ),
          )
      ]
      )
    );
  }
}