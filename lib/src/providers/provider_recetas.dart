// import 'dart:convert';


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/receta.dart';
import '../services/auth_service.dart';
// import 'package:vitamed/src/models/doctor.dart';

class ProviderRecetas extends ChangeNotifier {
  // final DatabaseReference _database = FirebaseDatabase.instance.ref();
// List<Doctor> _doctorList = [];
  List<Receta> _ListReceta = [];
  final AuthService _authService = AuthService();

//  List<Map<dynamic, dynamic>>  doctorList => get _doctorList;

  List<Receta> get listReceta => _ListReceta;
  // final _fire = FirebaseFireestores.instance;

  final DatabaseReference _recetasRef =
      FirebaseDatabase.instance.ref().child('recetas');

  // final DatabaseReference _recetasRef =
  //     FirebaseDatabase.instance.ref().child('recetas');

  Future<void> addRecetas(Map<String, dynamic> doctor) async {
    try {
      // Utiliza la referencia `doctorsRef` para agregar un nuevo doctor con ID único
      await _recetasRef.push().set(doctor);
      print("Recetas added successfully!");
      fetchRecet();
    } catch (error) {
      print("Failed to add doctor: $error");
    }
  }

  Future<void> fetchRecet() async {
    debugPrint('fetchRecetas para usuario ${_authService.currentUser!.uid}');

    // Referencia al nodo de recetas
    final DatabaseReference recetasRef =
        FirebaseDatabase.instance.ref().child('recetas');

    // Consulta para buscar recetas del usuario específico
    final Query query = recetasRef
        .orderByChild('usuario_id')
        .equalTo(_authService.currentUser!.uid);

    final DatabaseEvent event = await query.once();
    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      // Filtrar las recetas activas después de obtener los datos
      _ListReceta = data.entries
          .where((entry) => entry.value['statu'] == 'activo')
          .map((entry) {
        return Receta.fromJson(
            entry.key as String, entry.value as Map<dynamic, dynamic>);
      }).toList();

      print('Recetas filtradas: ${_ListReceta.length}');
    } else {
      print(
          "No se encontraron recetas para el usuario ${_authService.currentUser!.uid}.");
    }

    notifyListeners();
    // debugPrint('fetchDoctors');
    // // _doctorList.clear();
    // // _doctorListFilter.clear();
    // final DatabaseReference _doctorsRef =
    //     FirebaseDatabase.instance.ref().child('recetas');
    // final DatabaseEvent event = await _doctorsRef.once();

    // final snapshot = event.snapshot;

    // if (snapshot.value != null) {
    //   // Convierte el mapa en una lista
    //   final Map<dynamic, dynamic> data =
    //       snapshot.value as Map<dynamic, dynamic>;

    //   // print('Recetas  : ${jsonEncode(data)}');

    //   _ListReceta = data.entries.map((entry) {
    //     // entry.key es el ID
    //     return Receta.fromJson(
    //         entry.key as String, entry.value as Map<dynamic, dynamic>);
    //   }).toList();

    // } else {
    //   print("No se encontraron datos.");
    // }
    // notifyListeners();
  }

  Future<void> updateRecetaStatus(String recetaId) async {
    try {
      // Referencia al nodo específico de la receta
      final DatabaseReference recetaRef = FirebaseDatabase.instance.ref().child('recetas').child(recetaId);

      // Realizar la actualización del estado
      await recetaRef.update({
        'statu': 'terminado',
      });

      print(
          'Estado actualizado a "terminado" para la receta con ID: $recetaId');
      await fetchRecet();
    } catch (e) {
      print('Error al actualizar el estado: $e');
    }
  }
}
