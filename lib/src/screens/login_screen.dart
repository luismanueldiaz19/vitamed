import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vitamed/src/screens/reset_password_page.dart';
import 'package:vitamed/src/utils/helpers.dart';
import 'package:vitamed/src/widgets/validar_screen_available.dart';

import '../services/auth_service.dart';
import '../services/push_notification_services.dart';
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

  // ----------------------------------------------------------------------

  final TextEditingController _ocupacionController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  String? selectedGender = 'Masculino';

  String? selectedStatus =
      'Soltero'; // Variable para guardar el estado civil seleccionado
  final List<String> civilStatuses = [
    'Soltero',
    'Casado',
    'Divorciado',
    'Viudo',
    'Unión libre'
  ]; // Lista de opciones

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
        _displayNameController.text.isEmpty ||
        _ocupacionController.text.isEmpty ||
        _direccionController.text.isEmpty ||
        _telefonoController.text.isEmpty ||
        _ageController.text.isEmpty) {
      _showMessage("Por favor, rellene todos los campos");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Map the user data from the form fields
    final Map<String, dynamic> userData = {
      'nombre': _displayNameController.text.trim(),
      'edad': _ageController.text.trim(),
      'sexo': selectedGender,
      'estadoCivil': selectedStatus?.trim(),
      'ocupacion': _ocupacionController.text.trim(),
      'direccion': _direccionController.text.trim(),
      'telefono': _telefonoController.text.trim(),
      'email': _emailController.text.toLowerCase().trim(),
      'device_token': 'n/a',
    };

    // Llamada al servicio de registro
    final result = await _authService.registerWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      displayName: _displayNameController.text.trim(),
      userData: userData,
    );

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
      // PushNotificationServices pushNotificationServices =
      //     PushNotificationServices();

      // pushNotificationServices.sendNotificationToTopic(
      //     '¡Nuevo Registro!', 'Mr/Mis : ${_displayNameController.text.trim()}');

      // Navegar a la pantalla de bienvenida o dashboard
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => SplashScreen()),
        (route) => false,
      );
    } else {
      // Mostrar mensaje de error
      _showMessage(result ?? "Se ha producido un error desconocido");
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error de registro",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
      body: ValidarScreenAvailable(
        mobile: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                brightAqua,
                Color(0xFF004D40),
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
                  BounceInDown(
                    curve: Curves.elasticInOut,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/icon/logo_vitamed.jpg',
                            scale: 6)),
                  ),
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
                          Column(
                            children: [
                              SlideInRight(
                                curve: Curves.elasticInOut,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: CustomTextField(
                                      controller: _displayNameController,
                                      labelText: 'Full Name',
                                      icon: Icons.person),
                                ),
                              ),
                              SlideInLeft(
                                curve: Curves.elasticInOut,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: "Femenino",
                                          groupValue: selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedGender = value;
                                            });
                                          },
                                        ),
                                        const Text("Femenino"),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: "Masculino",
                                          groupValue: selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedGender = value;
                                            });
                                          },
                                        ),
                                        const Text("Masculino"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SlideInRight(
                                curve: Curves.elasticInOut,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: CustomTextField(
                                      controller: _ageController,
                                      labelText: 'Edad',
                                      icon: Icons.e_mobiledata,
                                      textInputType: TextInputType.number),
                                ),
                              ),
                              SlideInLeft(
                                curve: Curves.elasticInOut,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: SizedBox(
                                    height: 45,
                                    child: DropdownButton<String>(
                                      value: selectedStatus,
                                      hint: const Text(
                                          "Seleccione su estado civil"),
                                      isExpanded: true,
                                      items: civilStatuses.map((status) {
                                        return DropdownMenuItem<String>(
                                          value: status,
                                          child: Text(status),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedStatus = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SlideInRight(
                                curve: Curves.elasticInOut,
                                child: SizedBox(
                                    width: double.infinity,
                                    child: CustomTextField(
                                        controller: _ocupacionController,
                                        labelText: 'Ocupación',
                                        icon: Icons.work_history)),
                              ),
                              SlideInLeft(
                                curve: Curves.elasticInOut,
                                child: SizedBox(
                                    width: double.infinity,
                                    child: CustomTextField(
                                      controller: _direccionController,
                                      labelText: 'Direccion',
                                      icon: Icons.location_on_rounded,
                                    )),
                              ),
                              SlideInRight(
                                curve: Curves.elasticInOut,
                                child: SizedBox(
                                    width: double.infinity,
                                    child: CustomTextField(
                                        controller: _telefonoController,
                                        labelText: 'Telefono',
                                        textInputType: TextInputType.phone,
                                        icon: Icons.phone)),
                              ),
                            ],
                          ),

                        SlideInLeft(
                          curve: Curves.elasticInOut,
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomTextField(
                                controller: _emailController,
                                labelText: 'Email Address',
                                icon: Icons.email),
                          ),
                        ),
                        // const SizedBox(height: 15),
                        SlideInRight(
                          curve: Curves.elasticInOut,
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomTextField(
                                controller: _passwordController,
                                obscureText: true,
                                labelText: 'Password',
                                icon: Icons.lock),
                          ),
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
                                  child: Text(
                                      _isSignIn ? 'Continue' : 'Register',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Expanded(
                                child: Divider(
                                    thickness: 1, color: mutedGrayGreen)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Or Continue With',
                                  style: TextStyle(color: mutedGrayGreen)),
                            ),
                            Expanded(
                                child: Divider(
                                    thickness: 1, color: mutedGrayGreen)),
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
        windows: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    // color: Colors.red,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 1),
                                  child: Text('Sign In'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 1),
                                  child: Text('Sign Up'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [shadow]),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  if (!_isSignIn)
                                    Column(
                                      children: [
                                        SlideInRight(
                                          curve: Curves.elasticInOut,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: CustomTextField(
                                                controller:
                                                    _displayNameController,
                                                labelText: 'Full Name',
                                                icon: Icons.person),
                                          ),
                                        ),
                                        SlideInLeft(
                                          curve: Curves.elasticInOut,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    value: "Femenino",
                                                    groupValue: selectedGender,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedGender = value;
                                                      });
                                                    },
                                                  ),
                                                  const Text("Femenino"),
                                                ],
                                              ),
                                              const SizedBox(width: 20),
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    value: "Masculino",
                                                    groupValue: selectedGender,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedGender = value;
                                                      });
                                                    },
                                                  ),
                                                  const Text("Masculino"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SlideInRight(
                                          curve: Curves.elasticInOut,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: CustomTextField(
                                                controller: _ageController,
                                                labelText: 'Edad',
                                                icon: Icons.e_mobiledata,
                                                textInputType:
                                                    TextInputType.number),
                                          ),
                                        ),
                                        SlideInLeft(
                                          curve: Curves.elasticInOut,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: SizedBox(
                                              height: 45,
                                              child: DropdownButton<String>(
                                                value: selectedStatus,
                                                hint: const Text(
                                                    "Seleccione su estado civil"),
                                                isExpanded: true,
                                                items:
                                                    civilStatuses.map((status) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: status,
                                                    child: Text(status),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedStatus = newValue;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SlideInRight(
                                          curve: Curves.elasticInOut,
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: CustomTextField(
                                                  controller:
                                                      _ocupacionController,
                                                  labelText: 'Ocupación',
                                                  icon: Icons.work_history)),
                                        ),
                                        SlideInLeft(
                                          curve: Curves.elasticInOut,
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: CustomTextField(
                                                controller:
                                                    _direccionController,
                                                labelText: 'Direccion',
                                                icon: Icons.location_on_rounded,
                                              )),
                                        ),
                                        SlideInRight(
                                          curve: Curves.elasticInOut,
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: CustomTextField(
                                                  controller:
                                                      _telefonoController,
                                                  labelText: 'Telefono',
                                                  textInputType:
                                                      TextInputType.phone,
                                                  icon: Icons.phone)),
                                        ),
                                      ],
                                    ),

                                  SlideInLeft(
                                    curve: Curves.elasticInOut,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: CustomTextField(
                                          controller: _emailController,
                                          labelText: 'Email Address',
                                          icon: Icons.email),
                                    ),
                                  ),
                                  // const SizedBox(height: 15),
                                  SlideInRight(
                                    curve: Curves.elasticInOut,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: CustomTextField(
                                          controller: _passwordController,
                                          obscureText: true,
                                          labelText: 'Password',
                                          icon: Icons.lock),
                                    ),
                                  ),
                                  // const SizedBox(height: 15),
                                  _isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : SizedBox(
                                          width: 150,
                                          child: ElevatedButton(
                                            onPressed:
                                                _isSignIn ? _signIn : _register,
                                            style: ElevatedButton.styleFrom(
                                              elevation: 8.0,
                                              backgroundColor:
                                                  Color(0xFF004D40),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            child: Text(
                                                _isSignIn
                                                    ? 'Continue'
                                                    : 'Register',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: const [
                                      Expanded(
                                          child: Divider(
                                              thickness: 1,
                                              color: mutedGrayGreen)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text('Or Continue With',
                                            style: TextStyle(
                                                color: mutedGrayGreen)),
                                      ),
                                      Expanded(
                                          child: Divider(
                                              thickness: 1,
                                              color: mutedGrayGreen)),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordPage()),
                                );
                              },
                              child: Text(
                                'Olvidaste tu contraseña?',
                                style: style.bodySmall
                                    ?.copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: SizedBox(
                              width: 450,
                              child: Text(
                                leyend,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            brightAqua,
                            Color(0xFF004D40),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BounceInDown(
                            curve: Curves.elasticInOut,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(300),
                                child: Image.asset(
                                    'assets/icon/logo_vitamed.jpg',
                                    scale: 2)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
