import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_apk/controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  final TextEditingController _idController =
      TextEditingController(); // no se inicia sesion con username sino con email
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // Color verde para el título
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(context, 'Cédula', _idController),
                const SizedBox(height: 20),
                _buildTextField(context, 'Contraseña', _passwordController,
                    obscureText: true),
                const SizedBox(height: 40),
                Obx(() => _authController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : _buildLoginButton(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context, String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: const TextStyle(
          color: Colors.green, // Color verde para la etiqueta
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.green, width: 2), // Borde verde
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2), // Borde verde al enfocar
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.green, // Color verde para el botón
          ),
          onPressed: () {
            String username = _idController.text.trim();
            String password = _passwordController.text.trim();

            _authController.login(username, password);
          },
          child: const Text(
            'Iniciar Sesión',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white, // Texto blanco para el botón
            ),
          ),
        ),
      ),
    );
  }
}
