import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'preferences_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final PreferencesService _preferencesService = PreferencesService();
  User? get currentUser => _auth.currentUser;

  Future<String?> registerWithEmailAndPassword(String email, String password,
      {String? displayName, String? phoneNumber}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      // Verificar que el usuario no sea nulo antes de continuar
      // Verificar que el usuario no sea nulo antes de continuar
      if (user != null) {
        // Actualizar el perfil del usuario con displayName y phoneNumber
        await user.updateProfile(displayName: displayName);

        // Aquí puedes guardar el phoneNumber en tu base de datos o en SharedPreferences
        if (phoneNumber != null) {
          // Guarda el número de teléfono en la base de datos o en SharedPreferences
          // Implementa tu lógica de almacenamiento aquí,
          // await user.updatePhoneNumber(phoneNumber : displayName);
        }

        // Guarda el ID del usuario en SharedPreferences
        await _preferencesService.saveUserId(user.uid);
        return "success"; // Retornar éxito
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e
          .message; // Retorna el mensaje de error específico de FirebaseAuth
    } catch (e) {
      return "An unknown error occurred"; // Mensaje de error genérico
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Iniciar sesión y guardar el ID del usuario
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await _preferencesService
            .saveUserId(user.uid); // Guardar ID del usuario
        return "success";
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "An unknown error occurred";
    }
  }

  // Cerrar sesión y eliminar el ID del usuario
  Future<void> signOut() async {
    await _auth.signOut();
    await _preferencesService.clearUserId();
  }

  // Verificar si el usuario está autenticado
  Future<bool> isUserLoggedIn() async {
    return await _preferencesService.isUserLoggedIn();
  }

  // Método para obtener el ID del usuario guardado
  Future<String?> getUserId() async {
    return await _preferencesService.getUserId();
  }

  Future<String?> updateProfileImage(File image) async {
    try {
      // Verifica que haya un usuario autenticado
      User? user = _auth.currentUser;
      if (user == null) return 'No hay un usuario autenticado';

      // Define la referencia en Firebase Storage con el ID del usuario y fecha
      final ref = _storage.ref().child(
          'profiles_imagen/${user.uid}/${DateTime.now().toIso8601String()}');

      // Sube la imagen a Firebase Storage
      final uploadTask = ref.putFile(image);
      await uploadTask;

      // Obtiene la URL de descarga de la imagen
      final photoURL = await ref.getDownloadURL();
      // Actualiza el perfil del usuario con la nueva URL de la foto
      await user.updatePhotoURL(photoURL);
      // Refresca el perfil del usuario para obtener la URL actualizada
      await user.reload();
      return "Imagen de perfil actualizada exitosamente";
    } catch (e) {
      print("Error al actualizar la imagen de perfil: $e");
      return null;
    }
  }

// Verifica el número de teléfono y envía un código
  Future<void> verifyPhoneNumber(
      String phoneNumber, Function(String) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Esto se llama cuando la verificación es automática
        await _auth.currentUser!.updatePhoneNumber(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Maneja el error de verificación
        print('Error en la verificación: ${e.message}');
      },
      codeSent: (number, code) => {
        print('number : $number -  code : $code')
      }, // Llama a esta función con el ID de verificación
      codeAutoRetrievalTimeout: (String verificationId) {
        // Esto se llama cuando el tiempo de espera se agota
      },
    );
  }

  // Actualiza el número de teléfono
  Future<void> updatePhoneNumber(String verificationId, String smsCode) async {
    try {
      // Crea el credential de autenticación con el código SMS recibido
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Actualiza el número de teléfono del usuario
      await _auth.currentUser!.updatePhoneNumber(credential);
      print('Número de teléfono actualizado con éxito.');
    } catch (e) {
      print('Error al actualizar el número de teléfono: $e');
    }
  }
}
