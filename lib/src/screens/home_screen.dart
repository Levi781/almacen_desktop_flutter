import 'package:almacen_app_flutter/src/screens/activate_users_screen.dart';
import 'package:almacen_app_flutter/src/screens/create_category.dart';
import 'package:almacen_app_flutter/src/screens/create_product.dart';
import 'package:almacen_app_flutter/src/screens/details_product.dart';
import 'package:almacen_app_flutter/src/screens/preview_all_screen.dart';
import 'package:almacen_app_flutter/src/screens/preview_avaliable_screen.dart';
import 'package:almacen_app_flutter/src/screens/preview_report_not_screen.dart';
import 'package:almacen_app_flutter/src/screens/preview_report_screen.dart';
import 'package:almacen_app_flutter/src/screens/users_screen.dart';
import 'package:almacen_app_flutter/src/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almacen_app_flutter/src/screens/screens.dart';
import 'package:almacen_app_flutter/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegationModel = Provider.of<NavegacionModel>(context);
    final authServices = Provider.of<AuthServices>(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Image(
                            image: AssetImage('assets/uquifa2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text( authServices.user.nombre.toUpperCase() , style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        Text( authServices.user.role.toUpperCase()),
                      ],
                    ),
                  ),
                  CustomItem(
                    label: 'Inicio', 
                    color: Colors.white,
                    backcolor: Colors.deepPurple,
                    icon: Icons.home,
                    onPressed: (){
                      //final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                      navegationModel.paginaActual = 0;
                    }, 
                  ),
                  CustomItem(
                    label: 'Almacen', 
                    color: Colors.white,
                    backcolor: Colors.deepPurple,
                    icon: Icons.inventory_2,
                    onPressed: (){
                      //final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                      navegationModel.paginaActual = 1;
                    }, 
                  ),
                  CustomItem(
                    label: 'Entradas/Salidas', 
                    color: Colors.white,
                    backcolor: Colors.deepPurple,
                    icon: Icons.input,
                    onPressed: (){
                      //final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                      navegationModel.paginaActual = 2;
                    }, 
                  ),
                  CustomItem(
                    label: 'Reportes', 
                    color: Colors.white,
                    backcolor: Colors.deepPurple,
                    icon: Icons.file_present_sharp,
                    onPressed: (){
                      //final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                      navegationModel.paginaActual = 3;
                    }, 
                  ),
                  CustomItem(
                    label: 'Usuarios', 
                    color: Colors.white,
                    backcolor: Colors.deepPurple,
                    icon: Icons.group_outlined,
                    onPressed: (){
                      //final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                      navegationModel.paginaActual = 6;
                    }, 
                  ),
                  if(authServices.user.role == 'ADMIN_ROLE')
                  CustomItem(
                    label: 'Activar cuentas', 
                    color: Colors.white,
                    backcolor: Colors.deepPurple,
                    icon: Icons.account_circle_rounded,
                    onPressed: (){
                      //final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                      navegationModel.paginaActual = 10;
                    }, 
                  ),
                  const Spacer(),
                  CustomItem(
                    label: 'Cerrar sesión', 
                    color: Colors.white,
                    backcolor: Colors.red.shade300,
                    icon: Icons.logout,
                    onPressed: (){
                      //final navegationModel = Provider.of<NavegacionModel>(context, listen: false);
                      Navigator.pushReplacementNamed(context, 'login');
                    }, 
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: double.infinity,
              color: Colors.grey.shade400,
            ),
            Expanded(
              flex: 1,
              child: PageView(
                controller: navegationModel.pageController,
                children:  [
                  const DashboardScreen(), // 0
                  const WarehouseScreen(), // 1
                  const InputsScreen(), // 2
                  const ReportsScreen(), // 3 
                  const DetailProduct(), // 4 
                  CreateProduct(),// 5
                  const UsersScreen(), // 6
                  CreateCategoryScreen(),// 7
                  CreateUsersScreen(),//8
                  const PreviewReportScreen(), //9
                  const ActivateUsersScreen(), //10
                  const PreviewAllScreen(),// 11
                  const PreviewReportNotScreen(), //12
                  const PreviewReportAvailableScreen(), //13
                  

                ],
              )
            )
          ],
        )
      ),
    );
  }
}


class NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  final PageController _pageController = PageController(initialPage: 0);


  int get paginaActual => _paginaActual;

  set paginaActual(int paginaActual) {
    _paginaActual = paginaActual;
    _pageController.animateToPage( paginaActual, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;

}