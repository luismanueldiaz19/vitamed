import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitamed/src/screens/folder_screen_doctors/add_doctor_register.dart';
import 'package:vitamed/src/screens/folder_screen_doctors/editar_doctor.dart';
import 'package:vitamed/src/screens/splash_screen.dart';
import 'package:vitamed/src/utils/helpers.dart';

import '../../services/ImagePickerService.dart';
import '../../services/auth_service.dart';
import '../../utils/constants.dart';

class ScreenProfiles extends StatefulWidget {
  const ScreenProfiles({Key? key}) : super(key: key);

  @override
  State<ScreenProfiles> createState() => _ScreenProfilesState();
}

class _ScreenProfilesState extends State<ScreenProfiles> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final ImageUploadService _imageUploadService = ImageUploadService();

  final ImagePicker _picker = ImagePicker();

  bool _isUpdating = false;
  String? _initialName;

  @override
  void initState() {
    super.initState();
    User? current = _auth.currentUser;
    _initialName = current?.displayName;
    _nameController.text = _initialName ?? '';
  }

  Future<void> _updateProfile() async {
    try {
      setState(() => _isUpdating = true);
      if (_nameController.text != _initialName) {
        await _auth.currentUser?.updateDisplayName(_nameController.text);
        await _auth.currentUser?.reload();
        _initialName = _nameController.text;
      }
      setState(() {});
    } catch (e) {
      print("Error updating profile: $e");
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  Future<void> _updatePhoto() async {
    // Seleccionar imagen desde la galería
    final pickedImage = await _imageUploadService.pickImage(fromCamera: false);
    if (pickedImage == null) return;

    try {
      // Subir la imagen a Firebase Storage
      final String? photoURL = await _imageUploadService.uploadImage(
        pickedImage,
        _auth.currentUser!.uid,
      );

      if (photoURL != null) {
        // Actualizar la URL de la foto en Firebase Authentication
        await _auth.currentUser?.updatePhotoURL(photoURL);
        await _auth.currentUser?.reload();
        setState(() {});
      }
    } catch (e) {
      print("Error al actualizar la foto: $e");
    }
  }

  Future<void> _signOut(context) async {
    await AuthService().signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => SplashScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    User? current = _auth.currentUser;
    final style = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight / 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Mi Perfil',
                        style: fontTitle.copyWith(
                            fontSize: style.titleLarge?.fontSize)),
                    IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () => _signOut(context)),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: current?.photoURL != null
                      ? NetworkImage(current!.photoURL!)
                      : const AssetImage('assets/icon/logo_vitamed.jpg')
                          as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: _updatePhoto,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  onChanged: (_) =>
                      setState(() {}) // Habilita el botón si se cambia el texto
                  ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text("Información", style: fontTitle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre : ${current?.displayName ?? 'No disponible'}'),
                  Text('Email: ${current?.email ?? 'No disponible'}'),
                  Text(
                      'Ocupación : ${currentUsuario?.ocupacion ?? 'No disponible'}'),
                  Text(
                      'Direccion : ${currentUsuario?.direccion ?? 'No disponible'}'),
                  Text(
                      'Telefono : ${currentUsuario?.telefono ?? 'No disponible'}'),
                  Text('Sexo : ${currentUsuario?.sexo ?? 'No disponible'}'),
                  Text(
                      'Estado Civil : ${currentUsuario?.estadoCivil ?? 'No disponible'}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Divider(color: Colors.black38)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text("Last sesión", style: fontTitle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Último inicio de sesión: ${current?.metadata.lastSignInTime}'),
                  const SizedBox(height: 10),
                  Text('Cuenta creada: ${current?.metadata.creationTime}'),
                ],
              ),
            ),
            StreamBuilder<bool>(
              stream: availableStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(); // Mostramos un widget vacío mientras se espera
                } else if (snapshot.hasError) {
                  return const SizedBox(); // Mostramos un widget vacío si hay error
                } else if (!snapshot.hasData || snapshot.data == false) {
                  return const SizedBox(); // No mostrar nada si el valor es false o nulo
                }
                // Si el valor es true, mostramos el botón
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(color: Colors.red),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditarDoctor()),
                        );
                      },
                      child: const Text(
                        'Cambiar foto a Doctores',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        _isUpdating || _nameController.text == _initialName
                            ? null
                            : _updateProfile,
                    child: _isUpdating
                        ? const CircularProgressIndicator()
                        : const Text('Actualizar Perfil'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                identy(context),
              ],
            )
          ],
        ),
      ),
    );
  }

// {
//   "value": true
// }
  // Stream que se suscribe a los cambios en la colección de citas
  Stream<bool> get availableStream {
    final DatabaseReference _citasRef =
        FirebaseDatabase.instance.ref().child('available_edit');

    return _citasRef.onValue.map((event) {
      // Obtenemos el valor actual de available_edit
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      // Verificamos si tiene un valor true o false
      return data['value'] == true; // Cambia 'value' si la clave es diferente
    });
  }
}
// bool canEditCita(Cita cita) {
//   return cita.availableEdit;
// }
