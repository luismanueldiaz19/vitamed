import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vitamed/src/screens/reset_password_page.dart';
import 'package:vitamed/src/utils/helpers.dart';

import '../services/auth_service.dart';
import '../utils/constants.dart';
import 'splash_screen.dart';
// import 'package:vitamed/src/screens/folder_screen_main/home_screen.dart';
// import 'package:vitamed/src/screens/register_page.dart';
// import '../services/auth_service.dart';
// import 'folder_screen_main/page_navigator_screen.dart';
// import 'reset_password_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  bool _isSignIn = true;
  bool _isLoading = false;
  Future<void> _signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showMessage("Please fill in all fields");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Llamada al servicio de inicio de sesión
    final result = await _authService.signInWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
      // Navegar a la pantalla principal o de inicio después del inicio de sesión
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => SplashScreen()),
        (route) => false,
      );
    } else {
      // Mostrar mensaje de error
      _showMessage(result ?? "An unknown error occurred");
    }
  }

  Future<void> _register() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _displayNameController.text.isEmpty) {
      _showMessage("Please fill in all fields");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Llamada al servicio de registro
    final result = await _authService.registerWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      displayName: _displayNameController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
      // Navegar a la pantalla de bienvenida o dashboard
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => SplashScreen()),
        (route) => false,
      );
    } else {
      // Mostrar mensaje de error
      _showMessage(result ?? "An unknown error occurred");
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Registration Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    String leyend =
        'Inicie sesión para acceder a su médico personalizado, realizar un seguimiento del rendimiento de sus citas médicas y recibir recordatorios informados de instrucciones.';
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              brightAqua, // Aqua brillante
              // mutedGrayGreen, // Verde grisáceo apagado
              // Color(0xFF009688), // Verde claro similar al logo
              Color(0xFF004D40), // Verde oscuro para el contraste
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: kToolbarHeight),
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child:
                        Image.asset('assets/icon/logo_vitamed.jpg', scale: 6)),
                const SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(1),
                    fillColor: skyAqua,
                    selectedColor: Colors.white,
                    color: Colors.black38,
                    isSelected: [_isSignIn, !_isSignIn],
                    onPressed: (index) {
                      setState(() {
                        _isSignIn = index == 0;
                      });
                    },
                    children: const [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                        child: Text('Sign In'),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [shadow]),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      if (!_isSignIn)
                        SizedBox(
                          width: double.infinity,
                          child: CustomTextField(
                              controller: _displayNameController,
                              labelText: 'Full Name',
                              icon: Icons.email),
                        ),

                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                            controller: _emailController,
                            labelText: 'Email Address',
                            icon: Icons.email),
                      ),
                      // const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                            controller: _passwordController,
                            obscureText: true,
                            labelText: 'Password',
                            icon: Icons.lock),
                      ),
                      // const SizedBox(height: 15),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: _isSignIn ? _signIn : _register,
                                style: ElevatedButton.styleFrom(
                                  elevation: 8.0,
                                  backgroundColor: Color(0xFF004D40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(_isSignIn ? 'Continue' : 'Register',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Expanded(
                              child:
                                  Divider(thickness: 1, color: mutedGrayGreen)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Or Continue With',
                                style: TextStyle(color: mutedGrayGreen)),
                          ),
                          Expanded(
                              child:
                                  Divider(thickness: 1, color: mutedGrayGreen)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.g_mobiledata,
                                size: 36, color: Colors.red),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.apple,
                                size: 36, color: Colors.black),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.facebook,
                                size: 36, color: Colors.blue),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordPage()),
                    );
                  },
                  child: Text(
                    'Olvidaste tu contraseña?',
                    style: style.bodySmall?.copyWith(color: Colors.white38),
                  ),
                ),
                Text(
                  leyend,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white38),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
