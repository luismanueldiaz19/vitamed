import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:vitamed/src/models/cita.dart';

import '../services/auth_service.dart';

class ProviderCita extends ChangeNotifier {
  // List<Doctor> get doctorList => _doctorList;
  List<Cita> _listCita = [];
  List<Cita> get listCitas => _listCita;
  final DatabaseReference _citasRef =
      FirebaseDatabase.instance.ref().child('citas');
  final AuthService _authService = AuthService();

  Future<void> addCita(Map<String, dynamic> cita) async {
    try {
      // Utiliza la referencia `doctorsRef` para agregar un nuevo doctor con ID único
      await _citasRef.push().set(cita);
      print("Doctor added successfully!");
      // fetchDoctors();
    } catch (error) {
      print("Failed to add doctor: $error");
    }
  }

  // Stream que se suscribe a los cambios en la colección de citas
  Stream<List<Cita>> get citasStream {
    return _citasRef.onValue.map((event) {
      final citasMap = event.snapshot.value as Map<dynamic, dynamic>? ?? {};

      // Filtra solo las citas que cumplen las condiciones (usuario_id y is_availablre)
      return citasMap.entries.where((entry) {
        final citaData = Map<String, dynamic>.from(entry.value);
        return citaData['usuario_id'] == _authService.currentUser!.uid &&
            citaData['is_availablre'] == true;
      }).map((entry) {
        final citaData = Map<String, dynamic>.from(entry.value);
        return Cita.fromJson(citaData)..id = entry.key;
      }).toList();
    });
  }
}
