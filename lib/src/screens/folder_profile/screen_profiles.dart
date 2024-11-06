import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      // appBar: AppBar(
      //   title: const Text('Perfil'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       onPressed: _signOut,
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kTextTabBarHeight),
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
                ],
              ),
            ),
            const SizedBox(height: 10),
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
}
