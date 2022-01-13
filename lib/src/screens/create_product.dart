import 'package:almacen_app_flutter/src/models/products.dart';
import 'package:almacen_app_flutter/src/providers/providers.dart';
import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/products_services.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:almacen_app_flutter/src/widgets/custom_button.dart';
import 'package:almacen_app_flutter/src/widgets/custom_combobox.dart';
import 'package:almacen_app_flutter/src/widgets/custom_input.dart';
import 'package:almacen_app_flutter/src/widgets/custom_switchbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProduct extends StatelessWidget {
  CreateProduct({Key? key}) : super(key: key);

  final pruductName = TextEditingController();
  final pruductSerie = TextEditingController();
  final pruductDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);
    pruductSerie.text = productService.currentProduct.serie;
    pruductName.text = productService.currentProduct.name;
    pruductDesc.text = productService.currentProduct.description;

    return  Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 60, left:40, right: 40),

                children: [
                  SizedBox(width: 200,height: 40,
                    child: Align(child: 
                      Row(
                        children: [
                          IconButton(
                            focusColor: Colors.deepPurple,
                            onPressed: (){
                              final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                              navegationModel.paginaActual = 1;
                            }, 
                            icon: const Icon(Icons.arrow_back)),
                          const Text('Regresar')
                        ],
                      ), 
                    alignment: Alignment.centerLeft,),
                  ) ,
                  const Text('REGISTRO DE NUEVO PRODUCTO', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold )),
                  CustomInput(labelText: 'Nombre del producto', icon: Icons.app_registration, isPasswd: false, controller: pruductName),
                  const SizedBox(height: 10,),
                  CustomInput(labelText: 'Serie', icon: Icons.strikethrough_s_outlined, isPasswd: false, controller: pruductSerie),
                  const SizedBox(height: 10,),
                  CustomInput(labelText: 'Descripción', icon: Icons.description, isPasswd: false, controller: pruductDesc),
                  const SizedBox(height: 10,),
                  const CustomComboBox(),
                  const SizedBox(height: 10,),
                  const CustomSwitchBox(),
                  const SizedBox(height: 10,),
                  CustomButton(
                    onPressed: ()async{
                      final authService = Provider.of<AuthServices>(context, listen: false);
                      final categoryService = Provider.of<CategoryServices>(context, listen: false);
                      final categoryProvider = Provider.of<CreateProductProvider>(context, listen: false);

                      if(productService.currentProduct.id != null){

                        final newproduct = Producto(
                          id: productService.currentProduct.id,
                          user: authService.user.uid!,
                          category: Category(name: categoryService.currentCategory.name, id: categoryService.currentCategory.id! ),
                          disponible: categoryProvider.isEnabled,
                          description: pruductDesc.text,
                          name: pruductName.text,
                          serie: pruductSerie.text
                        );
                        
                        final res = await productService.putProduct( newproduct );
                        if(res){
                            pruductName.text = '';
                            pruductDesc.text = '';
                            pruductSerie.text = '';
                            showDialog(context: context, builder: (context){
                              return const AlertDialog(
                                title: Text('Producto actualizado correctamente'),
                              );
                            });
                          }else{
                            showDialog(context: context, builder: (context){
                              return const AlertDialog(
                                title: Text('Hubo errores al actualizar el producto, intentalo más tarde.'),
                              );
                            });
                          }

                      }else{
                        final newproduct = Producto(
                          user: authService.user.uid!,
                          category: Category(name: categoryService.currentCategory.name, id: categoryService.currentCategory.id! ),
                          disponible: categoryProvider.isEnabled,
                          description: pruductDesc.text,
                          name: pruductName.text,
                          serie: pruductSerie.text
                        );

                        final res = await productService.postProduct(newproduct);

                        if(res){
                          pruductName.text = '';
                          pruductDesc.text = '';
                          pruductSerie.text = '';
                          showDialog(context: context, builder: (context){
                            return const AlertDialog(
                              title: Text('Producto almacenado correctamente'),
                            );
                          });
                        }else{
                          showDialog(context: context, builder: (context){
                            return const AlertDialog(
                              title: Text('Hubo errores al insertar el producto, intentalo más tarde.'),
                            );
                          });
                        }
                      }



                    },
                    titulo: 'Almacenar', 
                    color: Colors.deepOrange
                  )
                   
                ],
              ), 
            ),

            Expanded(
              child: Container(
                child: ListView(
                  padding: const EdgeInsets.only(top: 150),
                  children: [
                    const Image(
                      image: AssetImage('assets/uquifa.png'),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 200.0),
                      child: CustomButton(onPressed: (){
                        //TODO: Examinar para ver las fotos o imagenes
                      }, titulo: 'Seleccionar imagen', color: Colors.red.shade300),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}