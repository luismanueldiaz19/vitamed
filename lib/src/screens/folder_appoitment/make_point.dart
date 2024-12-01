import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:vitamed/src/utils/constants.dart';

class AppointmentScheduler extends StatefulWidget {
  final Function? onTap;

  AppointmentScheduler({this.onTap});
  @override
  _AppointmentSchedulerState createState() => _AppointmentSchedulerState();
}

class _AppointmentSchedulerState extends State<AppointmentScheduler> {
  // Lista de horarios fijos base (para aleatorización)
  final List<String> baseTimes = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM'
  ];

  String? selectedDate = DateTime.now().toString().substring(0, 10);
  String? selectedTime;
  List<String> availableTimes = [];

  // Generar horarios aleatorios
  List<String> generateRandomTimes() {
    final random = Random();
    // Barajar la lista base de horarios
    baseTimes.shuffle(random);
    // Limitar los horarios a 3 aleatorios para esa fecha
    return baseTimes.take(7).toList();
  }

  DateTime? pickTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.black38, size: style.titleLarge?.fontSize),
                  const SizedBox(width: 10),
                  Text(DateFormat('MMMM').format(pickTime!)),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () async {
                        // Mostrar el selector de fecha
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025, 01, 31),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            pickTime = pickedDate;
                            selectedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            availableTimes =
                                generateRandomTimes(); // Generar horarios aleatorios
                            selectedTime =
                                null; // Resetear el horario cuando cambie la fecha
                          });
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios_outlined)),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Mostrar los horarios disponibles solo si se ha seleccionado una fecha
            if (selectedDate != null && availableTimes.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Horarios disponibles:', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  // Usamos GridView para mostrar los horarios
                  GridView.builder(
                    shrinkWrap:
                        true, // Permite que la cuadrícula ocupe el espacio disponible
                    physics:
                        NeverScrollableScrollPhysics(), // Desactiva el desplazamiento dentro de la grilla
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Número de columnas en la grilla
                      crossAxisSpacing: 10, // Espacio entre las columnas
                      mainAxisSpacing: 10, // Espacio entre las filas
                    ),
                    itemCount: availableTimes.length,
                    itemBuilder: (context, index) {
                      String time = availableTimes[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTime = time;

                            widget
                                .onTap!({'fecha': selectedDate, 'hour': time});
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: selectedTime == time
                                ? oceanBlue
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              time,
                              style: TextStyle(
                                // fontSize: 16,
                                color: selectedTime == time
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            SizedBox(height: 20),

            // Mostrar la selección final
            if (selectedDate != null && selectedTime != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Agendada para el ${selectedDate!} a las ${selectedTime!}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
          ],
        ),
      ),
    );
  }
}
