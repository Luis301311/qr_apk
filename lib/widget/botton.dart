import 'package:flutter/material.dart';

class PhotoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PhotoButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24), 
            backgroundColor: Colors.blueAccent,
          ),
          child: const Icon(Icons.person, color: Colors.black, size: 40),
        ),
        const SizedBox(height: 8), 
        const Text('Foto', style: TextStyle(color: Colors.black)), 
      ],
    );
  }
}

class BarcodeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BarcodeButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24), 
            backgroundColor: Colors.orangeAccent, 
          ),
          child: Image.network(
            'https://res.cloudinary.com/dkxiwcgla/image/upload/v1729888530/barcode_icon_172664_1_kwvnlc.png',
            width: 40, 
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, color: Colors.black); 
            },
          ),
        ),
        const SizedBox(height: 8), 
        const Text('Cód Barras', style: TextStyle(color: Colors.black)), 
      ],
    );
  }
}

class QRButton extends StatelessWidget {
  final VoidCallback onPressed;

  const QRButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24), 
            backgroundColor: Colors.greenAccent, 
          ),
          child: const Icon(Icons.qr_code, color: Colors.black, size: 40), 
        ),
        const SizedBox(height: 8), // Espacio entre el botón y el texto
        const Text('QR', style: TextStyle(color: Colors.black)), 
      ],
    );
  }
}
