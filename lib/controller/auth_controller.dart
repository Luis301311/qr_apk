import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:qr_apk/models/user.dart';
import 'package:qr_apk/pages/index_page_prueba.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_apk/pages/index_page.dart';


import 'package:qr_apk/pages/login_page.dart';


class AuthController extends GetxController {
  final String baseUrl = 'https://validate-qr.onrender.com'; // URL base de tu API.
  final storage = GetStorage();

  
  var isLoading = false.obs;
    var user = Rxn<User>(); 

  @override
  void onInit() {
    super.onInit();
    _autoLogin(); // Intento de login automático.
  }
  // Método para iniciar sesión con la API
   Future<String?> login(String id, String password) async {
    try {
     isLoading.value = true;
      final response = await http.post(
        Uri.parse('$baseUrl/auth'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String token = responseData['access_token'];
        await _saveToken(token);
        final qr = await qrGet(token);
        final user = await fetchUserProfile(token);
        Get.offAll(() => IndexPage(qr: qr, user: user,)); 
        return token; 
      } else {
        Get.snackbar("Error", "No se pudo iniciar sesión");
        return null;
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Ocurrió un error al iniciar sesión");
      return null;
    } finally {
      isLoading.value = false; 
    }
  }

  Future<String?> qrGet(String token) async {
      final response = await http.post(
        Uri.parse('$baseUrl/qr-code/generate/'+token),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        String qrImage = responseData['qrImage'];
          
         _saveQr(qrImage);
         return qrImage;// Retorna el token para su uso posterior
      } else {
        Get.snackbar("Error", "No se pudo iniciar obtner qr");
        return null;
      }
    }
    


  Future<User> fetchUserProfile(String token) async {
      // Obtener el token guardado
      final response = await http.get(
        Uri.parse('$baseUrl/students/user/profile'), 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', 
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
            User userInfo = User.fromJson(responseData);
          return userInfo;
      } else {
        Get.snackbar("Error", "No se pudo obtener el perfil del usuario");
        throw Exception("Error al obtener el perfil del usuario"); // Lanza una excepción
      }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _saveQr(String qrImage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('qrImage', qrImage);
  }

  Future<String?> _getQr() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('qrImage');
  }


  // Método para cerrar sesión
  Future<void> signOut() async {
    await _clearCredentials(); // Limpiar las credenciales guardadas.
    user.value = null;
    Get.snackbar("Sesión cerrada", "Hasta pronto");
    Get.offAll(() => LoginPage()); // Redirigir a la página de login.
  }

  

  // Intento de login automático usando credenciales guardadas.
  Future<void> _autoLogin() async {
    String? id = storage.read('id');
    String? password = storage.read('password');

    if (id != null && password != null) {
      await login(id, password);
    }
    
  }

  // Limpiar credenciales guardadas
  Future<void> _clearCredentials() async {
    storage.remove('id');
    storage.remove('password');
    storage.remove('name');
    storage.remove('lastName');
  }
}

