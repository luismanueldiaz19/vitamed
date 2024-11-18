import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class providerUsuario extends ChangeNotifier {
  final DatabaseReference _usuarioRef =
      FirebaseDatabase.instance.ref().child('usuarios');

  Future<void> addNuevoRegistro(Map<String, dynamic> usuario) async {
    try {
      // Utiliza la referencia `doctorsRef` para agregar un nuevo doctor con ID único
      await _usuarioRef.push().set(usuario);
      // print("_usuario Ref added successfully!");
    } catch (error) {
      print("Failed to add doctor: $error");
    }
  }
}
