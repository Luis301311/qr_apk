import 'package:flutter/material.dart';
import 'package:qr_apk/controller/auth_controller.dart';
import 'package:qr_apk/models/user.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:qr_apk/widget/botton.dart';

class IndexPage extends StatelessWidget {
  final  qr;
  final User user;
    final AuthController authController =
      Get.put(AuthController()); 


  IndexPage({required this.qr, required this.user});

  @override
  Widget build(BuildContext context) {
    // Decodifica la imagen en formato Base64
    Uint8List qrImageBytes = base64Decode(
      qr.replaceAll("data:image/png;base64,", ""),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Uparsistem '),
            ElevatedButton(
              onPressed: (){authController.signOut();}, 
              child: const Icon(Icons.exit_to_app, color: Colors.black, size: 40))
          ],
        ),
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
                padding:const  EdgeInsets.all(30.0),
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
                    const SizedBox(height: 16.0), // Espacio entre el QR y el nombre
                      Text(
                      '${user.name ?? ''} ${user.lastname ?? ''}', 
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0), // Espacio entre el nombre y el cargo
                    Text(
                      "CC : "+ user.id,
                      style: const TextStyle(fontSize: 19),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0), // Espacio entre el nombre y el cargo
                    const Text(
                      'Estudiante',
                      style: TextStyle(fontSize: 19),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16.0), 
                    Row(
                      children: [
                        PhotoButton(onPressed: () {
                          // Acción para el botón de foto
                        }),
                        const SizedBox(width: 10.0,),
                        BarcodeButton(onPressed: () {
                          // Acción para el botón de código de barras
                        }),
                        const SizedBox(width: 10.0,),
                        QRButton(onPressed: () {
                          
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

