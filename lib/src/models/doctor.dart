import 'dart:convert';

class Doctor {
  final String? id; // ID del doctor
  final String? nombre;
  final String? cedula;
  final String? centro;
  final String? codigo;
  final String? especialidad;
  final String? horarios;
  final String? telefono;
  final String? imageProfile;
  final String? informacion;
  final String? star;
  final bool? isFavorite;
  final List<String>? seguros;
  final List<Comment>? comments;

  Doctor({
    this.id,
    this.nombre,
    this.cedula,
    this.centro,
    this.codigo,
    this.especialidad,
    this.horarios,
    this.telefono,
    this.imageProfile,
    this.informacion,
    this.star,
    this.seguros,
    this.isFavorite,
    this.comments,
  });

  // Método para crear un Doctor a partir de un mapa
  factory Doctor.fromMap(String id, Map<dynamic, dynamic> data) {
    return Doctor(
      id: id,
      nombre: data['nombre'] ?? '',
      cedula: data['cedula'] ?? '',
      centro: data['centro'] ?? '',
      codigo: data['codigo'] ?? '',
      especialidad: data['especialidad'] ?? '',
      horarios: data['horarios'] ?? '',
      telefono: data['telefono'] ?? '',
      imageProfile: data['image_profile'] ?? '',
      informacion: data['informacion'] ?? '',
      star: data['star'] ?? '0.0',
      isFavorite: data['is_favorite'],
      seguros: List<String>.from(data['seguros'] ?? []),
      comments: (data['comment'] as List?)
              ?.map((item) =>
                  item is Map<String, dynamic> ? Comment.fromMap(item) : null)
              .whereType<Comment>()
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "cedula": cedula,
        "centro": centro,
        "codigo": codigo,
        "especialidad": especialidad,
        "horarios": horarios,
        "telefono": telefono,
        "image_profile": imageProfile,
        "informacion": informacion,
        "is_favorite": isFavorite,
        "star": star.toString(),
        "seguros": seguros,
        "comment": comments?.map((comment) => comment.toJson()).toList()
      };
}

class Comment {
  final String? cliente;
  final String? comment;
  final String? dateTime;
  final String? like;

  Comment({
    this.cliente,
    this.comment,
    this.dateTime,
    this.like,
  });

  factory Comment.fromMap(Map<String, dynamic> data) {
    return Comment(
      cliente: data['cliente'] ?? '',
      comment: data['comment'] ?? '',
      dateTime: data['date_time'] ?? '',
      like: data['like'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "cliente": cliente,
        "comment": comment,
        "date_time": dateTime,
        "like": like.toString(),
      };
}
