import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:qr_apk/widget/botton.dart';

class IndexPagePrueba extends StatelessWidget {
  // Cadena Base64 de una imagen QR estática para diseño
  final String qrImageData = "data:image/png;base64,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";
  // Asegúrate de reemplazarla con una cadena completa de Base64 para que funcione correctamente






  @override
  Widget build(BuildContext context) {
    // Decodifica la imagen en formato Base64
    Uint8List qrImageBytes = base64Decode(
      qrImageData.replaceAll("data:image/png;base64,", ""),
    );
return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Pageeeeees'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 25.0, left: 25.0), // Espacio alrededor del cuadro
        child: Center(
          child: Column(
            children: [
              Image.network(
                'https://res.cloudinary.com/dkxiwcgla/image/upload/v1729889047/iconoUparsistem_jrvver.png',
                width: 200,
                height: 200,
                
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, 
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0), 
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ajusta la altura del contenedor
                  crossAxisAlignment: CrossAxisAlignment.center, // Centra el contenido horizontalmente
                  children: [
                    Image.memory(
                      qrImageBytes,
                      fit: BoxFit.cover,
                      width: 200, // Ajusta el tamaño según sea necesario
                      height: 200,
                    ),
                    SizedBox(height: 16.0), // Espacio entre el QR y el nombre
                    Text(
                      'Luis Alberto Vega Moreno',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0), // Espacio entre el nombre y el cargo
                    Text(
                      'CC: 1066348730',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0), // Espacio entre el nombre y el cargo
                    Text(
                      'Estudiante',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: 16.0), 
                    Row(
                      children: [
                        PhotoButton(onPressed: () {
                          // Acción para el botón de foto
                        }),
                        const SizedBox(width: 15.0,),
                        BarcodeButton(onPressed: () {
                          // Acción para el botón de código de barras
                        }),
                        const SizedBox(width: 15.0,),
                        QRButton(onPressed: () {
                          // Acción para el botón de QR
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
