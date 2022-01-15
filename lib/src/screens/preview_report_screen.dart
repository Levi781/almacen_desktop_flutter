import 'dart:typed_data';
import 'package:almacen_app_flutter/src/models/inputs_outputs.dart';
import 'package:almacen_app_flutter/src/services/inputs_outputs_services.dart';
import 'package:almacen_app_flutter/src/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class PreviewReportScreen extends StatelessWidget {
  const PreviewReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final currentResult = Provider.of<InputOutputsServices>(context).currentResult;

    return Scaffold(
      body: PdfPreview(
        pdfFileName: 'ejemplo.pdf',
        build: ( format ) => generatorPDF( currentResult ),
      )
    );
  }

  Future<Uint8List> generatorPDF(Result result)async{
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/Arial.ttf");
    final image = await imageFromAssetBundle('assets/uquifa2.jpg');
    
    final prod = result.idp.img != null 
    ? await networkImage(baseURL+'uploads/productos/${result.idp.id}')
    : await imageFromAssetBundle('assets/uquifa2.jpg');

    

    final ttf = pw.Font.ttf(font);
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

        build: (context) =>[
          pw.SizedBox(height: 8),
           pw.Text(result.idp.name,
                        style: pw.TextStyle(
                            font: ttf,
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('192C6E'))),
          pw.SizedBox(height: 8),
          pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Salida: ${result.salida}'),
                    pw.Text('Entrada: ${result.entrada == '' ? 'Sin entrada' : 'result.entrada'}'),
                  ],
                ),
          pw.Center(
            child: pw.Container(
            margin: pw.EdgeInsets.all(25),
            width: 300,
            child: pw.Image( prod )
          )
          ),

        
          //pw.Divider(),
          pw.SizedBox(height: 12),
          pw.Text('DATOS DE PRODUCTO', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('000000'))),
          pw.SizedBox(height: 8),
          pw.Text('Serie', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('190F7B'))),
          pw.Text(result.idp.serie),
          pw.SizedBox(height: 8),
          pw.Text('Nombre', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('190F7B'))),
          pw.Text(result.idp.name),
          pw.SizedBox(height: 8),
          pw.Text('Descripcion', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('190F7B'))),
          pw.Text(result.idp.description),
          pw.SizedBox(height: 8),
          pw.Text('Categoria', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('190F7B'))),
          pw.Text(result.idp.category),
          
          pw.SizedBox(height: 12),
          pw.Text('DATOS DE USUARIO', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('000000'))),
          pw.SizedBox(height: 8),
          pw.Text('Nombre', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('190F7B'))),
          pw.Text(result.idu.nombre + ' '+ result.idu.apellidos),
          pw.SizedBox(height: 8),
          pw.Text('Departamento', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('190F7B'))),
          pw.Text(result.idu.depto),
          pw.SizedBox(height: 8),
          pw.Text('Puesto', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('190F7B'))),
          pw.Text(result.idu.puesto),
          
          
        ]

      )
    );
    

    return pdf.save();
  }
}