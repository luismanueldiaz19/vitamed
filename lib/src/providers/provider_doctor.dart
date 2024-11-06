// import 'dart:convert';

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/doctor.dart';
// import 'package:vitamed/src/models/doctor.dart';

class ProviderDoctor extends ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
// List<Doctor> _doctorList = [];
  List<Doctor> _doctorList = [];
  List<Doctor> _doctorListFilter = [];
//  List<Map<dynamic, dynamic>>  doctorList => get _doctorList;

  List<Doctor> get doctorList => _doctorList;
  List<Doctor> get doctorListFilter => _doctorListFilter;
  // final _fire = FirebaseFireestores.instance;

  final DatabaseReference _doctorsRef =
      FirebaseDatabase.instance.ref().child('doctors');

  Future<void> addDoctor(Map<String, dynamic> doctor) async {
    try {
      // Utiliza la referencia `doctorsRef` para agregar un nuevo doctor con ID único
      await _doctorsRef.push().set(doctor);
      print("Doctor added successfully!");
      fetchDoctors();
    } catch (error) {
      print("Failed to add doctor: $error");
    }
  }

  Future<void> fetchDoctors() async {
    debugPrint('fetchDoctors');
    _doctorList.clear();
    _doctorListFilter.clear();
    final DatabaseEvent event = await _doctorsRef.once();

    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      // Convierte el mapa en una lista
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      print('data : ${jsonEncode(data)}');

      _doctorList = data.entries.map((entry) {
        // entry.key es el ID
        return Doctor.fromMap(entry.key as String, entry.value as Map<dynamic, dynamic>);
      }).toList();
      _doctorListFilter = _doctorList;
      // // print("Datos de doctores: $_doctorList");
    } else {
      print("No se encontraron datos.");
    }
    notifyListeners();
  }

  Future<void> deleteDoctor(String id) async {
    await _doctorsRef.child(id).remove().then((_) {
      print("Doctor eliminado con ID: $id");
      // Actualiza la lista de doctores después de eliminar
      _doctorList.removeWhere((doctor) => doctor.id == id);
      _doctorList = _doctorListFilter;
      notifyListeners();
    }).catchError((error) {
      print("Error al eliminar el doctor: $error");
    });
  }
}
