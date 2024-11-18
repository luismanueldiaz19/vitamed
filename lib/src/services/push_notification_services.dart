import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PushNotificationServices {
  final _firebaseMesange = FirebaseMessaging.instance;
  Future generationDeviceRecognitionToken() async {
    final fCMToken = await _firebaseMesange.getToken();
    print('Token init notificacion :  $fCMToken');
    await updateDeviceToken(fCMToken!);
    await FirebaseMessaging.instance.subscribeToTopic("vitamed");
    await FirebaseMessaging.instance.subscribeToTopic("recetas");
    await FirebaseMessaging.instance.subscribeToTopic("doctor");
  }

  startListenForNewNotificacion(BuildContext context) async {
    // 1. Terminar
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? messange) {
      if (messange != null) {
        String? tripID = messange.notification?.title;
        print('title instance getInitialMessage : $tripID');
      }
    });

    // 2. Foreground

    FirebaseMessaging.onMessage.listen((RemoteMessage? event) {
      if (event != null) {
        String? tripID = event.notification?.title;
        print('title onMessage  listen: $tripID');
      }
    });

    // 2. Background

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? event) {
      if (event != null) {
        String? tripID = event.notification?.title;
        print('title onMessageOpenedApp  listen: $tripID');
      }
    });
  }
}

// final String fcmUrl =
//     'https://fcm.googleapis.com/v1/projects/vitamedd/messages:send';

// // Tu Server Key (NO lo expongas en el cliente en producción)
// final String serverKey = 'AIzaSyBEKF3_pdX4p8xopW1Ot-JlI8wxdJ5xdfo';
// // final String serverWebKey = 'AIzaSyBUHEHV7EtXHezDywFNGqiS8ggYbB4bMEs';
// // AIzaSyBUHEHV7EtXHezDywFNGqiS8ggYbB4bMEs

// // Método para enviar notificación al topic "vitamed"
// Future<void> sendNotificationToTopic(String title, String body) async {
//   try {
//     final response = await http.post(
//       Uri.parse(fcmUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$serverKey',
//       },
//       body: jsonEncode({
//         'to': '/topics/vitamed',
//         'notification': {
//           'title': title,
//           'body': body,
//         },
//         'priority': 'high',
//       }),
//     );

//     if (response.statusCode == 200) {
//       print('Notificación enviada exitosamente');
//     } else {
//       print('Error al enviar la notificación: ${response.body}');
//     }
//   } catch (e) {
//     print('Error enviando notificación: $e');
//   }
// }
// }

Future<void> updateDeviceToken(String nuevoToken) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Obtén el ID del usuario actual
    final usuarioId = user.uid;

    // Referencia a la raíz de "usuarios"
    final DatabaseReference usuariosRef =
        FirebaseDatabase.instance.ref().child('usuarios');

    // Consulta para buscar el nodo correspondiente al usuario actual
    final DataSnapshot snapshot = await usuariosRef.get();

    if (snapshot.exists) {
      // Iterar sobre los nodos para encontrar el usuarioId
      for (var child in snapshot.children) {
        final data = child.value as Map<dynamic, dynamic>;
        if (data['usuarioId'] == usuarioId) {
          // Nodo encontrado: actualiza el campo 'device_token'
          await usuariosRef.child(child.key!).update({
            'device_token': nuevoToken,
          });
          print('Token actualizado correctamente.');
          return;
        }
      }
      print('Usuario no encontrado.');
    } else {
      print('No existen usuarios en la base de datos.');
    }
  } else {
    print('No hay usuario autenticado.');
  }
}
