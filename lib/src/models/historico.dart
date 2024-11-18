// To parse this JSON data, do
//
//     final historico = historicoFromJson(jsonString);

import 'dart:convert';

Historico historicoFromJson(String str) => Historico.fromJson(json.decode(str));

String historicoToJson(Historico data) => json.encode(data.toJson());

class Historico {
  String? id;
  String? citaId;
  List<String>? pruebasSolicitadas;
  String? seguimiento;
  String? direccion;
  String? createdAt;
  String? edad;
  String? nombre;
  String? usuarioId;
  String? tratamiento;
  String? doctorId;
  String? motivoConsulta;
  String? diagnostico;
  Antecedentes? antecedentes;
  ExamenFisico? examenFisico;
  String? sexo;
  String? telefono;

  Historico({
    this.id,
    this.citaId,
    this.pruebasSolicitadas,
    this.seguimiento,
    this.direccion,
    this.createdAt,
    this.edad,
    this.nombre,
    this.usuarioId,
    this.tratamiento,
    this.doctorId,
    this.motivoConsulta,
    this.diagnostico,
    this.antecedentes,
    this.examenFisico,
    this.sexo,
    this.telefono,
  });

  factory Historico.fromJson(Map<dynamic, dynamic> json) => Historico(
        id: json["id"],
        citaId: json["citaId"],
        pruebasSolicitadas: json["pruebasSolicitadas"] == null
            ? []
            : List<String>.from(json["pruebasSolicitadas"]!.map((x) => x)),
        seguimiento: json["seguimiento"],
        direccion: json["direccion"],
        createdAt: json["created_at"],
        edad: json["edad"],
        nombre: json["nombre"],
        usuarioId: json["usuarioId"],
        tratamiento: json["tratamiento"],
        doctorId: json["doctor_id"],
        motivoConsulta: json["motivoConsulta"],
        diagnostico: json["diagnostico"],
        antecedentes: json["antecedentes"] == null
            ? null
            : Antecedentes.fromJson(json["antecedentes"]),
        examenFisico: json["examenFisico"] == null
            ? null
            : ExamenFisico.fromJson(json["examenFisico"]),
        sexo: json["sexo"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "citaId": citaId,
        "pruebasSolicitadas": pruebasSolicitadas == null
            ? []
            : List<dynamic>.from(pruebasSolicitadas!.map((x) => x)),
        "seguimiento": seguimiento,
        "direccion": direccion,
        "created_at": createdAt,
        "edad": edad,
        "nombre": nombre,
        "usuarioId": usuarioId,
        "tratamiento": tratamiento,
        "doctor_id": doctorId,
        "motivoConsulta": motivoConsulta,
        "diagnostico": diagnostico,
        "antecedentes": antecedentes?.toJson(),
        "examenFisico": examenFisico?.toJson(),
        "sexo": sexo,
        "telefono": telefono,
      };
}

class Antecedentes {
  String? enfermedadesPrevias;
  String? medicacionActual;

  Antecedentes({
    this.enfermedadesPrevias,
    this.medicacionActual,
  });

  factory Antecedentes.fromJson(Map<dynamic, dynamic> json) => Antecedentes(
        enfermedadesPrevias: json["enfermedadesPrevias"],
        medicacionActual: json["medicacionActual"],
      );

  Map<dynamic, dynamic> toJson() => {
        "enfermedadesPrevias": enfermedadesPrevias,
        "medicacionActual": medicacionActual,
      };
}

class ExamenFisico {
  String? presionArterial;
  String? temperatura;
  String? frecuenciaCardiaca;

  ExamenFisico({
    this.presionArterial,
    this.temperatura,
    this.frecuenciaCardiaca,
  });

  factory ExamenFisico.fromJson(Map<dynamic, dynamic> json) => ExamenFisico(
        presionArterial: json["presionArterial"],
        temperatura: json["temperatura"],
        frecuenciaCardiaca: json["frecuenciaCardiaca"],
      );

  Map<dynamic, dynamic> toJson() => {
        "presionArterial": presionArterial,
        "temperatura": temperatura,
        "frecuenciaCardiaca": frecuenciaCardiaca,
      };
}
