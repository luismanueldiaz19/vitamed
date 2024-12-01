import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/screens/folder_appoitment/historial_cita.dart';

import 'package:vitamed/src/widget/card_consultation.dart';
import 'package:vitamed/src/widget/widget_dividores.dart';
import 'package:vitamed/src/widgets/loading.dart';
import '../../models/cita.dart';
import '../../providers/provider_citas.dart';
import '../../services/auth_service.dart';
import '../../widget/my_widget_head.dart';
import '../../widgets/validar_screen_available.dart';
import '../folder_appoitment/detail_citas.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // final style = Theme.of(context).textTheme;
    final urlDocto =
        'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=926&fit=clip';
    final otherDocto =
        "https://cdn-ilabeod.nitrocdn.com/zUukpeMBluXkpSlgUMMfQZYBzJcUmlOw/assets/images/optimized/rev-64c54d1/russell6437.wpenginepowered.com/wp-content/uploads/2020/04/What-Is-An-Orthopedic-Doctor-In-Brooklyn.jpg";
    final citaProvider = Provider.of<ProviderCita>(context);
    return Scaffold(
      body: ValidarScreenAvailable(
        mobile: Column(
          children: [
            SizedBox(height: kToolbarHeight),
            MyWidgetHead(currenUser: _authService.currentUser),

            MyWidgetDivisores(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistorialCita()),
                );
              },
              title: 'Próxima consulta',
              text: 'Historial',
              icon: Icons.calendar_month_outlined,
            ),
            StreamBuilder<List<Cita>>(
              stream: citaProvider.citasStream,
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailCita(cita: cita)));
                              },
                              child: CardConsultation(
                                  imageUrl: urlDocto,
                                  appointmentDate:
                                      cita.date ?? 'Fecha no especificada',
                                  appointmentTime:
                                      cita.hour ?? 'Hora no especificada',
                                  doctorName:
                                      cita.nameDoctor ?? 'Doctor Desconocido',
                                  specialty: cita.especialidad ??
                                      'Especialidades Desconocido')));
                    },
                  ),
                );
              },
            ),
            // CardConsultation(imageUrl: urlDocto),
            // const SizedBox(height: 10),
            // CardConsultation(imageUrl: otherDocto),
          ],
        ),
      ),
    );
  }
}
