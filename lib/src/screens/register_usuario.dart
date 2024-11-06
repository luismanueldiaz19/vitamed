import 'package:flutter/material.dart';
import 'package:vitamed/src/utils/helpers.dart';

import '../utils/constants.dart';

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  // Controladores de texto para cada campo
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController claveController = TextEditingController();

  @override
  void dispose() {
    usuarioController.dispose();
    claveController.dispose();
    super.dispose();
  }

  // Función para simular el envío de datos
  void _submitForm() async {
    if (usuarioController.text.isNotEmpty && claveController.text.isNotEmpty) {
      // Simulación de envío de datos
      print("Usuario: ${usuarioController.text}");
      print("Clave: ${claveController.text}");
      //usuario, email, clave, fecha_registro
      var data = {
        'usuario': usuarioController.text.trim(),
        'email': usuarioController.text.trim(),
        'clave': claveController.text.trim(),
        'fecha_registro': DateTime.now().toString().substring(0, 19),
      };
      await registrarUser(data);
    }
  }

  Future registrarUser(data) async {
    // final ApiService _apiService = ApiService();
    // const String url =
    //     'http://$ipLocal/$pathHost/admin/insert/insert_registrar_usuario.php';
    // final res = await _apiService.postRequest(url, data);
    // print(res);
    // setState(() {
    //   usuarioController.clear();
    //   claveController.clear();
    // });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text("Registro exitoso")),
    // );
    //insert_registrar_usuario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            buildTextFieldValidator(
                label: 'Usuario',
                controller: usuarioController,
                hintText: 'Por favor ingresa el usuario'),
            buildTextFieldValidator(
                label: 'Password',
                controller: claveController,
                hintText: 'Por favor ingresa la clave'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
