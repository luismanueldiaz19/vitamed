import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vitamed/src/screens/folder_appoitment/view_details_historico.dart';
import 'package:vitamed/src/services/auth_service.dart';
import 'package:vitamed/src/widgets/validar_screen_available.dart';

import '../../models/cita.dart';
import '../../widget/card_consultation.dart';
import '../../widget/card_consultation_final.dart';
import '../../widgets/loading.dart';

class HistorialCita extends StatefulWidget {
  const HistorialCita({Key? key}) : super(key: key);

  @override
  _HistorialCitaState createState() => _HistorialCitaState();
}

class _HistorialCitaState extends State<HistorialCita> {
  final AuthService _authService = AuthService();

  final DatabaseReference _citasRef =
      FirebaseDatabase.instance.ref().child('citas');

  Stream<List<Cita>> get citasStream {
    return _citasRef.onValue.map((event) {
      final citasMap = event.snapshot.value as Map<dynamic, dynamic>? ?? {};

      // Filtra solo las citas que cumplen las condiciones (usuario_id y is_availablre)
      return citasMap.entries.where((entry) {
        final citaData = Map<String, dynamic>.from(entry.value);
        return citaData['usuario_id'] == _authService.currentUser!.uid &&
            citaData['is_availablre'] == false;
      }).map((entry) {
        final citaData = Map<String, dynamic>.from(entry.value);
        return Cita.fromJson(citaData)..id = entry.key;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final urlDocto =
        'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=926&fit=clip';
    return Scaffold(
      appBar: AppBar(
          title: const Text('Historial consultas'),
          backgroundColor: Colors.white),
      body: ValidarScreenAvailable(
        mobile: Column(
          children: [
            StreamBuilder<List<Cita>>(
              stream: citasStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar las citas.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: LoadingCustom(
                        text: 'No hay citas disponibles.',
                        image: 'assets/imagen/wired.gif',
                      ),
                    ),
                  );
                }

                final citas = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: citas.length,
                    itemBuilder: (context, index) {
                      Cita cita = citas[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: CardConsultationFinal(
                          cita: cita,
                          imageUrl: urlDocto,
                          appointmentDate: cita.date ?? 'Fecha no especificada',
                          appointmentTime: cita.hour ?? 'Hora no especificada',
                          doctorName: cita.nameDoctor ?? 'Doctor Desconocido',
                          specialty:
                              cita.especialidad ?? 'Especialidades Desconocido',
                        ),
                      );

                      //  ListTile(
                      //   leading: cita.imageProfileDoctor != null
                      //       ? CircleAvatar(
                      //           backgroundImage:
                      //               NetworkImage(cita.imageProfileDoctor!),
                      //         )
                      //       : CircleAvatar(child: Icon(Icons.person)),
                      //   title: Text(cita.nameDoctor ?? 'Doctor Desconocido'),
                      //   subtitle: Text(cita.date ?? 'Fecha no especificada'),
                      //   trailing: Text(cita.hour ?? 'Hora no especificada'),
                      //   onTap: () {
                      //     // Maneja la acción al tocar en una cita
                      //   },
                      // );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
