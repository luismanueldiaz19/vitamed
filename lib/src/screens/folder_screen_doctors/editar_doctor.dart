import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/models/doctor.dart';
import 'package:vitamed/src/providers/provider_doctor.dart';
import 'package:vitamed/src/screens/folder_screen_doctors/add_doctor_register.dart';
import 'package:vitamed/src/utils/constants.dart';

import '../../services/ImagePickerService.dart';

class EditarDoctor extends StatefulWidget {
  const EditarDoctor({Key? key}) : super(key: key);

  @override
  _EditarDoctorState createState() => _EditarDoctorState();
}

class _EditarDoctorState extends State<EditarDoctor> {
  final ImageUploadService _imageUploadService = ImageUploadService();

  @override
  Widget build(BuildContext context) {
    final doctorList =
        Provider.of<ProviderDoctor>(context, listen: true).doctorListFilter;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de doctores'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddDoctorRegister()));
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: doctorList.length,
              itemBuilder: (context, index) {
                Doctor doctor = doctorList[index];
                return Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 75,
                          maxWidth: 75,
                          minHeight: 60,
                          minWidth: 60,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content:
                                      Image.network(doctor.imageProfile ?? ''),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(doctor.imageProfile ?? '')),
                        )),
                    title: Text(doctor.nombre ?? 'N/A'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.especialidad ?? 'N/A',
                          style: TextStyle(color: Colors.black45),
                        ),
                        Text(
                          doctor.consultorio ?? 'N/A',
                          style: TextStyle(color: oceanBlue),
                        )
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () => _updatePhoto(doctor),
                      icon: Icon(Icons.camera_sharp),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _updatePhoto(Doctor doctor) async {
    //image_profile

    // Seleccionar imagen desde la galería
    final pickedImage = await _imageUploadService.pickImage(fromCamera: false);
    if (pickedImage == null) return;

    try {
      // Subir la imagen a Firebase Storage
      final String? photoURL = await _imageUploadService.uploadImageToDoctor(
        pickedImage,
        doctor.id.toString(),
      );

      if (photoURL != null) {
        await actualizarUrl(doctor, photoURL);
        await Provider.of<ProviderDoctor>(context, listen: false)
            .fetchDoctors();
        setState(() {});
      }
    } catch (e) {
      print("Error al actualizar la foto: $e");
    }
  }

  Future actualizarUrl(Doctor doctor, urlImagen) async {
    // Referencia a la base de datos
    DatabaseReference doctorsRef = FirebaseDatabase.instance.ref('doctors');

    // Actualizar el campo image_profile del doctor especificado
    doctorsRef.child(doctor.id ?? '').update({
      'image_profile': urlImagen,
    }).then((_) {
      print('Imagen actualizada correctamente');
    }).catchError((error) {
      print('Error al actualizar la imagen: $error');
    });
  }
}
