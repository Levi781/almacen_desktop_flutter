import 'package:almacen_app_flutter/src/services/products_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    return Scaffold(
      body: Center(
        child: _showGraph( productService )
      ),
    );
  }

  Widget _showGraph( ProductsService service  ){

    late Map<String, double> dataMap = {
    };
    dataMap.putIfAbsent('Asignados', () => double.parse(service.noproductos.length.toString()));
    dataMap.putIfAbsent('En Stock', () => double.parse(service.siproductos.length.toString()));

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: PieChart(
        dataMap: dataMap,
      )
      );
  }
}



