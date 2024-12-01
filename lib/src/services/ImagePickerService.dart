import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  /// Seleccionar imagen desde la galería o la cámara
  Future<File?> pickImage({bool fromCamera = false}) async {
    final pickedFile = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  /// Subir imagen a Firebase Storage y obtener la URL de descarga
  Future<String?> uploadImage(File image, String userId) async {
    try {
      // Crear una referencia única en Firebase Storage para la imagen
      final ref = _storage
          .ref()
          .child('profiles_imagen/$userId/${DateTime.now().toIso8601String()}');

      // Subir la imagen
      final uploadTask = ref.putFile(image);
      await uploadTask;

      // Obtener la URL de descarga
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error al subir la imagen: $e");
      return null;
    }
  }

  /// Subir imagen a Firebase Storage y obtener la URL de descarga
  Future<String?> uploadImageToDoctor(File image, String userId) async {
    try {
      // Crear una referencia única en Firebase Storage para la imagen
      final ref = _storage.ref().child(
          'profiles_imagen_doctor/$userId/${DateTime.now().toIso8601String()}');

      // Subir la imagen
      final uploadTask = ref.putFile(image);
      await uploadTask;

      // Obtener la URL de descarga
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error al subir la imagen: $e");
      return null;
    }
  }
}
