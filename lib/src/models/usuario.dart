class Usuario {
  String direccion;
  String edad;
  String email;
  String estadoCivil;
  String nombre;
  String ocupacion;
  String sexo;
  String telefono;
  String usuarioId;

  Usuario({
    required this.direccion,
    required this.edad,
    required this.email,
    required this.estadoCivil,
    required this.nombre,
    required this.ocupacion,
    required this.sexo,
    required this.telefono,
    required this.usuarioId,
  });

  // Método para convertir un JSON a un objeto Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      direccion: json['direccion'],
      edad: json['edad'],
      email: json['email'],
      estadoCivil: json['estadoCivil'],
      nombre: json['nombre'],
      ocupacion: json['ocupacion'],
      sexo: json['sexo'],
      telefono: json['telefono'],
      usuarioId: json['usuarioId'],
    );
  }

  // Método para convertir un objeto Usuario a JSON
  Map<String, dynamic> toJson() {
    return {
      'direccion': direccion,
      'edad': edad,
      'email': email,
      'estadoCivil': estadoCivil,
      'nombre': nombre,
      'ocupacion': ocupacion,
      'sexo': sexo,
      'telefono': telefono,
      'usuarioId': usuarioId,
    };
  }
}
