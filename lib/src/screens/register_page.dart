import 'package:flutter/material.dart';
import 'package:vitamed/src/screens/folder_screen_main/home_screen.dart';
import 'package:vitamed/main.dart';
import '../services/auth_service.dart';
import 'reset_password_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ///token : UcgeS7lzg3fMojAHw19yUnAxYg53

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final result = await _authService.registerWithEmailAndPassword(
        email,
        password,
        displayName: _displayNameController.text.trim(),
        phoneNumber: _phoneNumberController.text.isEmpty
            ? null
            : _phoneNumberController.text.trim(),
      );

      if (result == "success") {
        print("result : ${result}");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Vitamed')),
          (Route<dynamic> route) =>
              false, // Elimina todas las pantallas anteriores
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _displayNameController,
                validator: (value) => value!.isEmpty ? "Display Name" : null,
                decoration: InputDecoration(labelText: 'Display Name'),
              ),
              TextFormField(
                controller: _phoneNumberController,
                // validator: (value) =>
                //     value!.isEmpty ? "Enter a Phone Number" : null,
                decoration:
                    InputDecoration(labelText: 'Phone Number (optional)'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Enter a valid email" : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? "Enter a password 6+ chars long" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
