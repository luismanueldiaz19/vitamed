import 'package:flutter/material.dart';

class Doctor {
  final String? id; // ID del doctor
  final String? nombre;
  final String? centro;
  final String? consultorio;
  final String? especialidad;
  final String? horarios;
  final String? telefono;
  final String? imageProfile;
  final String? informacion;
  final double? star;
  final String? exequarter;
  final bool? isFavorite;
  final List<String>? seguros;

  Doctor({
    this.id,
    this.nombre,
    this.centro,
    this.consultorio,
    this.especialidad,
    this.horarios,
    this.telefono,
    this.imageProfile,
    this.informacion,
    this.star,
    this.seguros,
    this.isFavorite,
    this.exequarter,
  });

  // Método para crear un Doctor a partir de un mapa
  factory Doctor.fromMap(String id, Map<dynamic, dynamic> data) {
    return Doctor(
        id: id,
        nombre: data['nombre'] ?? '',
        centro: data['centro'] ?? '',
        consultorio: data['consultorio'] ?? '',
        especialidad: data['especialidad'] ?? '',
        horarios: data['horarios'] ?? '',
        telefono: data['telefono'] ?? '',
        imageProfile: data['image_profile'] ?? '',
        informacion: data['informacion'] ?? '',
        star: data['star'] != null ? data['star'] ?? 0.0 : 0.0,
        isFavorite: data['is_favorite'],
        exequarter: data['exequarter'],
        seguros: List<String>.from(data['seguros'] ?? []));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "centro": centro,
        "consultorio": consultorio,
        "especialidad": especialidad,
        "horarios": horarios,
        "telefono": telefono,
        "image_profile": imageProfile,
        "informacion": informacion,
        "is_favorite": isFavorite,
        "star": star.toString(),
        "seguros": seguros,
        "exequarter": exequarter,
      };

  static List<String> getUniqueCategoria(List<Doctor> list) {
    Set<String> objectoSet =
        list.map((element) => element.especialidad!).toSet();
    print(objectoSet.toList());
    return objectoSet.toList();
  }
}

class EspecialidadesIconos {
  // Mapa de especialidades e íconos
  static final Map<String, IconData> especialidadIconos = {
    "Nutrición Clínica": Icons.sports_gymnastics_rounded,
    "Gastroenterólogo": Icons.local_dining,
    "Neurocirujano": Icons.psychology,
    "Cirujano de Columna Vertebral": Icons.back_hand,
    "Cirujano General y Laparoscopista": Icons.medical_services,
    "Oftalmólogo": Icons.remove_red_eye,
    "Cardiólogo": Icons.favorite,
    "Especialidad e Glaucoma": Icons.visibility,
    "Neumología": Icons.air,
    "Medicina Interna": Icons.local_hospital,
    "Nefrología": Icons.water_drop,
    "Odontología": Icons.toll_outlined,
    "Pediatra": Icons.child_care,
    "Nutrición Pediatra": Icons.lunch_dining,
    "Neurología": Icons.medical_services,
    "Dermatología": Icons.spa,
    "Ortopeda": Icons.healing,
    "Cirujano Pediatra y Neonatal": Icons.baby_changing_station,
    "Médico General": Icons.medical_services,
    "Ginecología-Obstetra": Icons.pregnant_woman,
    "Colposcopista": Icons.search,
    "Oncología Clínica": Icons.biotech,
    "Pediatra- Neonatología": Icons.cruelty_free,
    "Nutrióloga": Icons.restaurant_menu,
    "Endocrinólogo": Icons.bloodtype,
    "Urólogo": Icons.water
  };

  // Método para obtener el ícono
  static IconData getIconForEspecialidad(String especialidad) {
    return especialidadIconos[especialidad] ??
        Icons.help; // Ícono predeterminado si no existe
  }
}
