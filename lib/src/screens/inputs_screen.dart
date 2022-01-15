import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:almacen_app_flutter/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputsScreen extends StatelessWidget {
  const InputsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputsService = Provider.of<InputOutputsServices>(context);
    final productsService = Provider.of<ProductsService>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 25,
           
          ),
          Expanded(
            child: ListView.builder(
              itemCount: inputsService.inputsOutputs.length,
              itemBuilder: (context, indice){
                final input = inputsService.inputsOutputs[indice];
                return Container(
                  margin: const EdgeInsets.only(bottom: 5, left:25, right: 25),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Nombre: ', style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            Text( input.idu.nombre +' ' + input.idu.apellidos )
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Producto: ', style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            Text( input.idp.name )
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Serie: ', style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            Text( input.idp.serie )
                          ],
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text( input.entrada == '' ? 'Entrada: Sin entregar' :'Entrada: ${input.entrada}', style: TextStyle(fontSize: 20),),
                            Text( 'Salida: ${input.salida}' , style: const TextStyle(fontSize: 20),),
                          ],
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            input.entrada == ''
                            ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextButton(onPressed: ()async{
                                  await inputsService.putRegisterInput( input.id, input.idu.id, input.idp.id);
                                  await productsService.getProducts();
                                }, child: const Text('Entregar', style: TextStyle(fontWeight: FontWeight.bold,))),
                            )
                            : const Text('Sin pendiente', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,)),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade300,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextButton(onPressed: ()async{
                                  inputsService.currentResult = input;
                                  final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                                  navegationModel.paginaActual = 9;
                                }, child: const Text('Reporte', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                            )
                          ],
                        )
                        
                      ],
                    ),
                  ),
                );
              }
            )
          )
        ],
      )
    );
  }
}