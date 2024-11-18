import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:vitamed/src/models/usuario.dart';
import '../permission/permission_device.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import 'folder_screen_main/home_screen.dart';
import 'folder_screen_main/page_navigator_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService authService = AuthService();
  PermissionMethonds permissionMethonds = PermissionMethonds();

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
    permission();
  }

  permission() async {
    await permissionMethonds.askPermissionNotificacion();
  }

  // Método para revisar si el usuario está autenticado
  Future<void> _checkAuthentication() async {
    bool isAuthenticated = await authService.isUserLoggedIn();
    // Simulamos un pequeño retraso para que el splash sea visible por un tiempo
    await Future.delayed(const Duration(seconds: 2));
    // print('isAuthenticated : $isAuthenticated');
    if (isAuthenticated) {
      authService.getUserId();
      final usuariLocal = await authService.getUsuario();
      currentUsuario = Usuario.fromJson(json.decode(usuariLocal!));
      print('usuario de preferencia ${currentUsuario?.toJson()}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PageNavigatorScreen()),
      );
    } else {
      // Si no está autenticado, lo rediriges a la pantalla Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElasticIn(
          curve: Curves.elasticInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                      Image.asset('assets/icon/logo_vitamed.jpg', height: 150)),
              const SizedBox(height: 20),
              const CircularProgressIndicator(), // Indicador de carga
              const SizedBox(height: 20),
              Text('Verificando usuario , Cargando...',
                  style: style.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
