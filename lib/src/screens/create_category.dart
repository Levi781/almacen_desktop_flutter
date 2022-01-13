import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:almacen_app_flutter/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCategoryScreen extends StatelessWidget {
  CreateCategoryScreen({Key? key}) : super(key: key);

  final nameCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100, left: 100, right: 100),
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
            ),
            const SizedBox(height: 15,),
            const Text('Nueva categoria', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            CustomInput(labelText: 'Nombre de categoria', icon: Icons.category_outlined, isPasswd: false, controller: nameCategory),
            CustomButton(onPressed: ()async{
              final categoryService = Provider.of<CategoryServices>(context, listen: false);
              final authService = Provider.of<AuthServices>(context, listen: false);
              final saveCategory = await categoryService.postCategory(nameCategory.text, authService.user.uid.toString());
              if(saveCategory){
                final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                navegationModel.paginaActual = 1;
              }else{
                showDialog(context: context, builder: (context){
                  return const AlertDialog( title: Text('Intentalo más tarde. Tuvimos unos problemas con el servidor'),);
                });
              }
            }, titulo: 'Almacenar', color: Colors.deepPurple)
          ],
        ),
      )
    );
  }
}