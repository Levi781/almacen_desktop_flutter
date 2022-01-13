import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:almacen_app_flutter/src/screens/home_screen.dart';
import 'package:almacen_app_flutter/src/screens/login_screen.dart';
import 'package:almacen_app_flutter/src/screens/register_screen.dart';
import 'package:almacen_app_flutter/src/services/services.dart';
import 'package:almacen_app_flutter/src/providers/providers.dart';

void main() => runApp( const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavegacionModel()),
        ChangeNotifierProvider(create: (_) => ProductsService(),),
        ChangeNotifierProvider(create: (_) => UsersServices(),),
        ChangeNotifierProvider(create: (_) => AuthServices(),),
        ChangeNotifierProvider(create: (_) => CategoryServices(),),
        ChangeNotifierProvider(create: (_) => CreateProductProvider(),),
        ChangeNotifierProvider(create: (_) => CreateUsersProvider(),),
        ChangeNotifierProvider(create: (_) => InputOutputsServices(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'home': (_) => const HomeScreen(),
          'login': ( _ )=> const LoginScreen(),
          'register': ( _ ) => const RegisterScreen()
        },
      ),
    );
  }
}