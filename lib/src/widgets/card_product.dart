import 'package:almacen_app_flutter/src/models/products.dart';
import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/auth_services.dart';
import 'package:almacen_app_flutter/src/services/products_services.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:almacen_app_flutter/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardProduct extends StatelessWidget {

  final Producto producto;

  const CardProduct({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<NavegacionModel>(context);
    return Container(
      child: Card(
        color: Colors.deepPurple[50],
        child: Container(
          child: Column(
            children: [
              
              Container(
                margin: const EdgeInsets.only(top: 15, bottom:10),
                height: 120, 
                child: Stack(
                  children: [

                    Container(
                      width: double.infinity,
                      child: producto.img != null
                      ? Image(image: NetworkImage('http://localhost:8081/api/uploads/productos/'+producto.id!),fit: BoxFit.contain)
                      : const Image(
                        image: AssetImage('assets/uquifa2.jpg'),
                        fit: BoxFit.contain,
                      )                      
                    ),
                    IconButton(onPressed: (){
                      final productService = Provider.of<ProductsService>(context, listen:false);
                      productService.currentProduct = producto;
                      navegationModel.paginaActual = 5;

                    }, icon: const Icon(Icons.edit, color: Colors.deepOrange,)),

                    Positioned(
                      right: 10,
                      child: IconButton(onPressed: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text('Estas a punto de eliminar un producto. ¿Deseas continuar?'),
                            actions: [
                              TextButton(onPressed: ()async{
                                final productService = Provider.of<ProductsService>(context, listen:false);
                                final authService = Provider.of<AuthServices>(context, listen:false);
                                await productService.deleteProduct( producto.id!,authService.user.uid! );
                                Navigator.pop(context);
                              }, child: const Text('Continuar')),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text('Cancelar')),
                            ]
                          );
                        });
                    
                      }, icon: const Icon(Icons.delete, color: Colors.purple,)),
                    )
                  ],
                ),
              ),
              Text( producto.name , style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 1 ),
              Text( producto.serie ),
              CustomButton(onPressed: ()async{
                 final productService = Provider.of<ProductsService>(context, listen:false);
                 final usersServices = Provider.of<UsersServices>(context, listen: false );
                 await usersServices.getAllUsersDataClients();
                  productService.currentProduct = producto;
                  navegationModel.paginaActual = 4;
              }, 
              titulo: 'Ver producto', color: Colors.deepPurple)

            ],
          ),
        ),
      )
    );
  }
}