// To parse this JSON data, do
//
//     final cita = citaFromJson(jsonString);

// import 'dart:convert';

// Map<String, Cita> citaFromJson(String str) => Map.from(json.decode(str))
//     .map((k, v) => MapEntry<String, Cita>(k, Cita.fromJson(v)));

// String citaToJson(Map<String, Cita> data) => json.encode(
//     Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Cita {
  String? id;
  String? date;
  String? doctorId;
  String? nameDoctor;
  String? hour;
  String? usuarioId;
  String? centro;
  String? notaCita;
  String? imageProfileDoctor;
  String? recetaId;
  String? especialidad;
  bool? isAvailablre;
  String? username;

  Cita({
    this.id,
    this.date,
    this.doctorId,
    this.nameDoctor,
    this.hour,
    this.usuarioId,
    this.centro,
    this.notaCita,
    this.imageProfileDoctor,
    this.recetaId,
    this.especialidad,
    this.isAvailablre,
    this.username,
  });

  factory Cita.fromJson(Map<dynamic, dynamic> json) => Cita(
        id: json["id"],
        date: json["date"],
        doctorId: json["doctor_id"],
        nameDoctor: json["name_doctor"],
        hour: json["hour"],
        usuarioId: json["usuario_id"],
        centro: json["centro"],
        notaCita: json["nota_cita"],
        imageProfileDoctor: json["image_profile_doctor"],
        recetaId: json["receta_id"],
        especialidad: json["especialidad"],
        isAvailablre: json["is_availablre"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "doctor_id": doctorId,
        "name_doctor": nameDoctor,
        "hour": hour,
        "usuario_id": usuarioId,
        "centro": centro,
        "nota_cita": notaCita,
        "image_profile_doctor": imageProfileDoctor,
        "receta_id": recetaId,
        "especialidad": especialidad,
        "is_availablre": isAvailablre,
        "username": username,
      };
}
