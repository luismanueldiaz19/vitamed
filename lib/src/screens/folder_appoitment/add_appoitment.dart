import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/providers/provider_citas.dart';
import 'package:vitamed/src/screens/folder_appoitment/make_point.dart';
import 'package:vitamed/src/utils/constants.dart';
import 'package:vitamed/src/widgets/loading.dart';
import 'package:vitamed/src/widgets/validar_screen_available.dart';
import '../../models/doctor.dart';
import '../../services/auth_service.dart';
import 'package:uuid/uuid.dart';
import '../../services/notification_service.dart';
import '../folder_screen_main/page_navigator_screen.dart';

class AddAppoitment extends StatefulWidget {
  const AddAppoitment({super.key, this.doctor});
  final Doctor? doctor;
  @override
  State<AddAppoitment> createState() => _AddAppoitmentState();
}

class _AddAppoitmentState extends State<AddAppoitment> {
  final AuthService _authService = AuthService();
  DateTime selectedDate = DateTime.now();
  String? hourPicked;
  String? dateTime;
  bool isLoading = false;
  // Genera la lista de días para el mes seleccionado
  // Al seleccionar un día, se actualiza la disponibilidad de horas para ese día

  appoitmentMethod() async {
    if (hourPicked!.isEmpty || dateTime!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Elegir la hora disponible'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }
    setState(() {
      isLoading = !isLoading;
    });
    var uuid = Uuid();
    var v1 = uuid.v1();
    var appoitment = {
      'doctor_id': widget.doctor?.id,
      'name_doctor': widget.doctor?.nombre,
      'especialidad': widget.doctor?.especialidad,
      'hour': hourPicked,
      'date': '$dateTime',
      'usuario_id': _authService.currentUser?.uid,
      'username': _authService.currentUser?.displayName,
      'nota_cita': 'N/A',
      'centro': widget.doctor?.centro,
      'receta_id': v1,
      'is_availablre': true,
      'image_profile_doctor': widget.doctor?.imageProfile,
    };
    // Crear el mensaje de la notificación utilizando los datos del mapa
    String notificationBody =
        'Dr. ${appoitment['name_doctor']} (${appoitment['especialidad']})\n'
        'Fecha: ${appoitment['date']}\n'
        'Hora: ${appoitment['hour']}\n'
        'Centro: ${appoitment['centro']}\n';
    await Provider.of<ProviderCita>(context, listen: false).addCita(appoitment);
    await esperar();
    await NotificationService.showNotificacion(
      title: 'Cita con ${appoitment['name_doctor']} programada',
      body: notificationBody,
      summary: '¡Recuerda tu cita!',
      notificationLayout: NotificationLayout.Messaging,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PageNavigatorScreen()),
    );
    // setState(() {
    //   isLoading = !isLoading;
    // });
  }

  Future esperar() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final sized = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Agendar cita'), backgroundColor: Colors.white),
      body: ValidarScreenAvailable(
        mobile: isLoading
            ? LoadingCustom(
                image: 'assets/icon/logo_vitamed.jpg', text: 'Creando cita')
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight / 2, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor?.nombre ?? 'N/A',
                          style: style.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.doctor?.centro ?? 'N/A',
                          style: style.bodySmall?.copyWith(color: oceanBlue),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: style.titleMedium?.fontSize),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                Text('Distancia '),
                                const SizedBox(width: 5),
                                Text('(2.4Km)'),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(child: AppointmentScheduler(onTap: (datos) {
                    print(datos);
                    hourPicked = datos['hour'];
                    dateTime = datos['fecha'];
                  })),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SizedBox(
                      width: sized.width,
                      child: ElevatedButton(
                        onPressed: appoitmentMethod,
                        child: Text(
                          'Terminar'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 12,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => darkTeal,
                          ),
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
