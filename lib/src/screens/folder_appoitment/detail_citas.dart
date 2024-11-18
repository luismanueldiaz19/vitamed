import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vitamed/src/widgets/loading.dart';
import 'dart:io';
import '../../models/cita.dart';
import '../../utils/constants.dart';
import '../folder_screen_main/page_navigator_screen.dart';

class DetailCita extends StatefulWidget {
  const DetailCita({super.key, this.cita});
  final Cita? cita;

  @override
  State<DetailCita> createState() => _DetailCitaState();
}

class _DetailCitaState extends State<DetailCita> {
  // Controladores para los TextFields
  final TextEditingController _indicacionesController = TextEditingController();
  // ------------------------------------------------
  final TextEditingController _motivoConsultaController =
      TextEditingController();
  final TextEditingController _analisisController = TextEditingController();
  // final TextEditingController _cantidadDiasController = TextEditingController();
  // final TextEditingController _cantidadDiasController = TextEditingController();

  File? _imageFile;
  String? _imageUrl;
  double _uploadProgress = 0.0; // Variable de estado para el progreso
  bool isLoading = false;
  // Mapa para almacenar los datos
  Map<String, dynamic> data = {};

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    // Mostrar diálogo para elegir entre Cámara o Galería
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Seleccionar imagen"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Cámara"),
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                    await _uploadImageToFirebase();
                  }
                  if (!mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Galería"),
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                    await _uploadImageToFirebase();
                  }
                  if (!mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Método para subir imagen a Firebase Storage con progreso
  Future<void> _uploadImageToFirebase() async {
    if (_imageFile == null) return;
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('recetas/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_imageFile!);

      // Escuchar el progreso de la carga
      uploadTask.snapshotEvents.listen((event) {
        setState(() {
          _uploadProgress = (event.bytesTransferred / event.totalBytes) * 100;
        });
      });

      // Esperar a que se complete la carga
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = downloadUrl;
        data['path_imagen'] = downloadUrl; // Guardar la URL en el mapa
        _uploadProgress = 0.0; // Restablecer el progreso después de cargar
      });
    } catch (e) {
      print('Error al subir la imagen: $e');
      setState(() {
        _uploadProgress = 0.0; // Restablecer el progreso en caso de error
      });
    }
  }

  agregarIndicacion() async {
    final DatabaseReference _recetaRef =
        FirebaseDatabase.instance.ref().child('recetas');
    final DatabaseReference _historialMedicoRef =
        FirebaseDatabase.instance.ref().child('historial_medicos');

    final DatabaseReference recetaRef =
        FirebaseDatabase.instance.ref().child('citas').child(widget.cita!.id!);

    if (_indicacionesController.text.isEmpty ||
        _motivoConsultaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error Fomulario'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() {
      isLoading = !isLoading;
      data['created_at'] = DateTime.now().toString().substring(0, 19);
      data['indicaciones'] = _indicacionesController.text;
      // data['frecuencia'] = _frecuenciaController.text;
      // data['cantidad_dias'] = _cantidadDiasController.text;
      data['doctor_id'] = widget.cita!.doctorId;
      data['path_imagen'] = _imageUrl != null ? _imageUrl : 'N/A';
      data['name_doctor'] = widget.cita!.nameDoctor;
      data['receta_id'] = widget.cita!.recetaId;
      data['especialidad'] = widget.cita!.especialidad;
      data['usuario_id'] = widget.cita!.usuarioId;
      data['centro'] = widget.cita!.centro;
      data['date_cita'] = widget.cita!.date;
      data['statu'] = 'activo';
      data['resultado'] = 'tratamiento en espera..';
      data['citaId'] = widget.cita?.id;
    });
    print('Datos guardados: $data');
    Map<String, dynamic> historialMedico = {
      'usuarioId': currentUsuario?.usuarioId,
      'nombre': currentUsuario?.nombre,
      'edad': currentUsuario?.edad,
      'sexo': currentUsuario?.sexo,
      'telefono': currentUsuario?.telefono,
      'direccion': currentUsuario?.direccion,
      'motivoConsulta': _motivoConsultaController.text,
      'doctor_id': widget.cita!.doctorId,
      'citaId': widget.cita?.id,
      'created_at': DateTime.now().toString().substring(0, 19),
      'pruebasSolicitadas': _analisisController.text.isNotEmpty
          ? _analisisController.text.split(',').map((e) => e.trim()).toList()
          : [
              'Sin analisis',
            ],
      'antecedentes': {
        'enfermedadesPrevias': 'Ninguna',
        'medicacionActual': 'No hay datos'
      },
      'examenFisico': {
        'presionArterial': '0/0 mmHg',
        'temperatura': 'sin datos °C',
        'frecuenciaCardiaca': 'sin datos'
      },
      'diagnostico': 'aun sin datos',
      'tratamiento': _indicacionesController.text,
      'seguimiento': 'Aun no publicado',
    };
    await _recetaRef.push().set(data);
    await _historialMedicoRef.push().set(historialMedico);

    print("Doctor added successfully!"); // Realizar la actualización del estado
    await recetaRef.update({'is_availablre': false});

    await esperar();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PageNavigatorScreen()),
    );
    // setState(() {
    //   isLoading = !isLoading;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Detalles de la cita'),
      ),
      body: isLoading
          ? LoadingCustom(
              text: 'Registrando Indicación',
              image: 'assets/icon/logo_vitamed.jpg')
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_imageFile != null)
                      Column(
                        children: [
                          LinearProgressIndicator(value: _uploadProgress / 100),
                          Text('${_uploadProgress.toStringAsFixed(0)}%'),
                        ],
                      ),
                    // Botón para seleccionar imagen
                    if (_imageUrl != null)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Image.network(_imageUrl!)),
                    TextField(
                        controller: _motivoConsultaController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: 'Motivo de consulta')),
                    // Campo para indicaciones
                    TextField(
                      controller: _indicacionesController,
                      decoration:
                          const InputDecoration(labelText: 'Indicaciones'),
                      onChanged: (value) {
                        data['indicaciones'] = value;
                      },
                    ),
                    TextField(
                      controller: _analisisController,
                      decoration: const InputDecoration(
                          labelText:
                              'Analisis solicitados (separados por comas)'),
                      onChanged: (value) {
                        data['pruebasSolicitadas'] = value;
                      },
                    ),

                    // Campo para frecuencia
                    // TextField(
                    //   controller: _frecuenciaController,
                    //   keyboardType: TextInputType.number,
                    //   decoration: const InputDecoration(
                    //       labelText: 'Frecuencia (en horas)'),
                    //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    //   onChanged: (value) {
                    //     data['frecuencia'] = value;
                    //   },
                    // ),
                    // // Campo para cantidad de días
                    // TextField(
                    //   controller: _cantidadDiasController,
                    //   keyboardType: TextInputType.number,
                    //   decoration:
                    //       const InputDecoration(labelText: 'Cantidad de Días'),
                    //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    //   onChanged: (value) {
                    //     data['cantidad_dias'] = value;
                    //   },
                    // ),

                    const SizedBox(height: 20),
                    // Botón para guardar datos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                            icon: Icon(Icons.image),
                            onPressed: _pickImage,
                            label: const Text('Imagen')),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: agregarIndicacion,
                            child: Text('Guardar Datos'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => darkTeal),
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future esperar() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}




// Map<String, dynamic> historialMedico = {
//   'usuarioId': currentUsuario?.usuarioId,
//   'nombre': currentUsuario?.nombre,
//   'edad': currentUsuario?.edad,
//   'sexo': currentUsuario?.sexo,
//   'motivoConsulta': _motivoConsultaController.text,
//   'doctor_id': widget.cita!.doctorId,
//   'antecedentes': {
//     'enfermedadesPrevias': 'Ninguna',
//     'medicacionActual': 'Naproxeno 500 mg',
//   },
//   'examenFisico': {
//     'presionArterial': '120/80 mmHg',
//     'temperatura': '36.5°C',
//     'frecuenciaCardiaca': '75 lpm',
//   },
//   'diagnostico': 'Cefalea tensional',
//   'tratamiento': 'Analgésicos y descanso',
//   'seguimiento': 'Control en 2 semanas',
//   'pruebasSolicitadas': [
//     'Hemograma completo',
//     'Radiografía de tórax',
//   ],
// };
