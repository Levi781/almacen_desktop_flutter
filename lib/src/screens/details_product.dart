import 'package:almacen_app_flutter/src/models/users_data.dart';
import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/products_services.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';
import 'package:almacen_app_flutter/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context).currentProduct;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Container(width: 200,height: 40,
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
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('NOMBRE DEL PRODUCTO', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                    Text( productService.name, style: const TextStyle(color: Colors.black, fontSize: 30),),
                    const SizedBox(height: 10,),
                    const Text('SERIE', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                    Text( productService.serie, style: const TextStyle(color: Colors.black, fontSize: 15),),
                    const SizedBox(height: 10,),
                    const Text('DESCRIPCIÓN', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                    Text( productService.description, style: const TextStyle(color: Colors.black, fontSize: 15),),
                    const SizedBox(height: 10,),
                    const Text('CATEGORIA', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                    Text( productService.category.name, style: const TextStyle(color: Colors.black, fontSize: 15),),
                    const SizedBox(height: 10,),
                    const Text('DISPONIBLE', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                    Text( productService.disponible ? 'Si' : 'No', style: const TextStyle(color: Colors.black, fontSize: 30),),
                    const SizedBox(height: 10,),
                  ],
                ),
                if(productService.img!= null)
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 300, height: 300,
                    child: Image(image: NetworkImage(baseURL+'uploads/productos/${productService.id}'))
                  ),
              ],
            ),

            if(productService.disponible == true )
              const Text('ASIGNAR A USUARIO', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
            if(productService.disponible == true )
              Row(
                children: [
                  const CustomComboBoxUsers(),
                  CustomButton(onPressed: ()async{
                    final usersServices = Provider.of<UsersServices>(context, listen: false );
                    final inputsServices = Provider.of<InputOutputsServices>(context, listen: false );
                    final prodService = Provider.of<ProductsService>(context, listen: false );
                    await inputsServices.postRegisterInput(usersServices.currentClientUser.id!, productService.id!);
                    await prodService.getProducts();

                    await showDialog(context: context, builder: (context){
                      return const AlertDialog(
                        title: Text('Producto asignado'),
                      );
                    });

                    final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                    navegationModel.paginaActual = 1;

                  }, titulo: 'Asignar', color: Colors.deepPurple),
                ],
              )
          ],
        )
      )
    );
  }
}


class CustomComboBoxUsers extends StatefulWidget {

  const CustomComboBoxUsers({Key? key}) : super(key: key);

  @override
  State<CustomComboBoxUsers> createState() => _CustomComboBoxStateUsers();
}

class _CustomComboBoxStateUsers extends State<CustomComboBoxUsers> {
  @override
  Widget build(BuildContext context) {
    final usersServices = Provider.of<UsersServices>(context); // Instancia de provider 
    
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
                const Text('Nombre de usuario: ', style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold,)),
                DropdownButton<User>(            
                  value: usersServices.currentClientUser,
                  borderRadius: BorderRadius.circular(20),
                  underline: Container(),
                  onChanged: (newValue) {
                     usersServices.currentClientUser = newValue!;
                     setState(() {
                       
                     });
                  },
                  items: <User>[...usersServices.usuariosData]
                      .map<DropdownMenuItem<User>>((User value) {
                    return DropdownMenuItem<User>(
                      value: value,
                      child: Text(value.nombre +' '+ value.apellidos, style: const TextStyle(fontSize: 17),),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}