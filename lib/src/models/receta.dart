// To parse this JSON data, do
//
//     final receta = recetaFromJson(jsonString);

// import 'dart:convert';

class Receta {
  String? cantidadDias;
  String? centro;
  String? createdAt;
  String? dateCita;
  String? doctorId;
  String? especialidad;
  String? frecuencia;
  String? indicaciones;
  String? nameDoctor;
  String? pathImagen;
  String? recetaId;
  String? resultado;
  String? statu;
  String? usuarioId;
  String? id;

  Receta({
    this.cantidadDias,
    this.centro,
    this.createdAt,
    this.dateCita,
    this.doctorId,
    this.especialidad,
    this.frecuencia,
    this.indicaciones,
    this.nameDoctor,
    this.pathImagen,
    this.recetaId,
    this.resultado,
    this.statu,
    this.usuarioId,
    this.id,
  });

  factory Receta.fromJson(String id, Map<dynamic, dynamic> json) => Receta(
        cantidadDias: json["cantidad_dias"],
        centro: json["centro"],
        createdAt: json["created_at"],
        dateCita: json["date_cita"],
        doctorId: json["doctor_id"],
        especialidad: json["especialidad"],
        frecuencia: json["frecuencia"],
        indicaciones: json["indicaciones"],
        nameDoctor: json["name_doctor"],
        pathImagen: json["path_imagen"],
        recetaId: json["receta_id"],
        resultado: json["resultado"],
        statu: json["statu"],
        usuarioId: json["usuario_id"],
        id: id,
      );

  Map<String, dynamic> toJson() => {
        "cantidad_dias": cantidadDias,
        "centro": centro,
        "created_at": createdAt,
        "date_cita": dateCita,
        "doctor_id": doctorId,
        "especialidad": especialidad,
        "frecuencia": frecuencia,
        "indicaciones": indicaciones,
        "name_doctor": nameDoctor,
        "path_imagen": pathImagen,
        "receta_id": recetaId,
        "resultado": resultado,
        "statu": statu,
        "usuario_id": usuarioId,
        "id": id,
      };
}
