import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vitamed/src/models/usuario.dart';

import '../utils/constants.dart';
import 'preferences_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final PreferencesService _preferencesService = PreferencesService();
  User? get currentUser => _auth.currentUser;
  final DatabaseReference _usuarioRef =
      FirebaseDatabase.instance.ref().child('usuarios');
  Future<String?> registerWithEmailAndPassword(String email, String password,
      {String? displayName,
      String? phoneNumber,
      Map<String, dynamic>? userData}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
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

        userData?['usuarioId'] = user.uid.toString();
        currentUsuario = Usuario.fromJson(userData!);
        await _preferencesService.saveUsuarioLocal(json.encode(userData));
        await _usuarioRef.push().set(userData);
        return "success"; // Retornar éxito
      }
      //HSOnwY3MOEWL3p6Ilmg6E4G6wRt2
      //HSOnwY3MOEWL3p6Ilmg6E4G6wRt2
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
        final DatabaseReference usuariosRef =
            FirebaseDatabase.instance.ref().child('usuarios');

        // Consulta para buscar los datos del usuario
        final Query query =
            usuariosRef.orderByChild('usuarioId').equalTo(user.uid);

        final DatabaseEvent event = await query.once();

        final snapshot = event.snapshot;

        if (snapshot.value != null) {
          print(snapshot.value);
          final Map<String, dynamic> data =
              Map<String, dynamic>.from(snapshot.value as Map);
          // Aquí asumimos que la clave del nodo del usuario es desconocida, por eso usamos `data.values.first`
          final Map<String, dynamic> usuarioData =
              Map<String, dynamic>.from(data.values.first);
          // Mapear datos a la clase Usuario
          currentUsuario = Usuario.fromJson(usuarioData);
          await _preferencesService.saveUserId(user.uid);
          await _preferencesService
              .saveUsuarioLocal(json.encode(currentUsuario));
          return "success";
        } else {
          return null;
        }
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
    await _preferencesService.clearUsuario();
  }

  // Verificar si el usuario está autenticado
  Future<bool> isUserLoggedIn() async {
    return await _preferencesService.isUserLoggedIn();
  }

  // Método para obtener el ID del usuario guardado
  Future<String?> getUserId() async {
    return await _preferencesService.getUserId();
  }

  // Método para obtener el ID del usuario guardado
  Future<String?> getUsuario() async {
    return await _preferencesService.getUsuario();
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
