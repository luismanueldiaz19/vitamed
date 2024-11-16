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
}
