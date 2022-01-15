import 'dart:typed_data';
import 'package:almacen_app_flutter/src/models/inputs_outputs.dart';
import 'package:almacen_app_flutter/src/models/products.dart';
import 'package:almacen_app_flutter/src/services/inputs_outputs_services.dart';
import 'package:almacen_app_flutter/src/services/products_services.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class PreviewReportNotScreen extends StatelessWidget {
  const PreviewReportNotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final currentResult = Provider.of<ProductsService>(context).noproductos;

    return Scaffold(
      body: PdfPreview(
        pdfFileName: '.pdf',
        build: ( format ) => generatorPDF( currentResult ),
      )
    );
  }

  Future<Uint8List> generatorPDF(List<Producto> result)async{
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/Arial.ttf");
    final image = await imageFromAssetBundle('assets/uquifa2.jpg');
    
    // final prod = result.idp.img != null 
    // ? await networkImage(baseURL+'uploads/productos/${result.idp.id}')
    // : await imageFromAssetBundle('assets/uquifa2.jpg');

    

    final ttf = pw.Font.ttf(font);
    final styleLabels = pw.TextStyle( color: PdfColor.fromHex('000000'), fontSize: 9, fontWeight: pw.FontWeight.bold );
    final styleInfos = pw.TextStyle( color: PdfColor.fromHex('000000'), fontSize: 9);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        header: (context){
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
              
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(children: [
                  pw.Image(image, width: 25, height: 25),
                  pw.SizedBox(width: 10),
                  pw.Text('Uquifa S.A de C.V',
                    style: pw.TextStyle(
                    font: ttf,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('192C6E'))),
                  ]
                ),
                pw.Text('REPORTE DE SALIDAS',
                        style: pw.TextStyle(
                            font: ttf,
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('192C6E'))),
              ]
              ),
                pw.SizedBox(height: 5),
                pw.Text('Fecha de creación: ${DateTime.now().toString().split('.')[0]}'),
                pw.SizedBox(height: 5),
                pw.Container(
                  width: double.infinity,
                  height: 3,
                  color: PdfColor.fromHex('74349c')
                ),
          ]);
        },

        footer: (context){
          return pw.Column(
            children: [
              pw.Container(
                  width: double.infinity,
                  height: 3,
                  color: PdfColor.fromHex('74349c')
                ),
                pw.Align(
                  child: pw.Text('Página ${context.pageNumber} / ${context.pagesCount}'),
                  alignment: pw.Alignment.centerRight
                )
            ],
          );
        },

       
        build: (context) => [
          pw.SizedBox(height: 10),
          pw.Text('Reporte de todas las salidas sin retorno.'),
          pw.SizedBox(height: 10),
          
          pw.ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, indice){

              final item = result[indice];
              final prod = item.img != null 
              ? networkImage(baseURL+'uploads/productos/${item.id}')
              : imageFromAssetBundle('assets/uquifa2.jpg');

              return pw.Container(
                padding:const pw.EdgeInsets.only(left: 15,bottom: 5, top: 5 ),
                margin: const pw.EdgeInsets.only( bottom: 10),
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(20),
                  color: PdfColor.fromHex('E4E2F5')
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.Text('ID: ', style: styleLabels),
                          pw.Text( item.id!, style: styleInfos),
                        ],),
                        pw.Row(children: [
                          pw.Text('Nombre: ', style: styleLabels),
                          pw.Text( item.name, style: styleInfos),
                        ],),
                        pw.Row(children: [
                          pw.Text('Serie: ', style: styleLabels),
                          pw.Text( item.serie , style: styleInfos),
                        ],),
                      ]
                    ),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.Text('Categoria: ', style: styleLabels),
                          pw.Text( item.category.name, style: styleInfos),
                        ],),
                        //pw.( prod )
                      ]
                    ),
                    )
                  ],
                )
              );
            }, 
          )
          
        ]

      )
    );
    

    return pdf.save();
  }
}