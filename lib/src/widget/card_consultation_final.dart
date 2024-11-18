import 'package:flutter/material.dart';
import 'package:vitamed/src/models/cita.dart';
import 'package:vitamed/src/utils/constants.dart';

import '../screens/folder_appoitment/view_details_historico.dart';

class CardConsultationFinal extends StatelessWidget {
  final String imageUrl;
  final String doctorName;
  final String specialty;
  final String appointmentDate;
  final String appointmentTime;
  final Cita? cita;

  const CardConsultationFinal({
    Key? key,
    required this.imageUrl,
    this.doctorName = 'Dr. Alexander Vasilenko',
    this.specialty = 'Especialidades',
    this.appointmentDate = '24 Sept',
    this.appointmentTime = '19:30',
    this.cita,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white, skyAquaLight],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Sombra gris semitransparente
            spreadRadius: 5, // Extensión de la sombra
            blurRadius: 15, // Difuminado de la sombra
            offset: Offset(4, 4), // Posición de la sombra (x, y)
          ),
          BoxShadow(
            color: Colors.white, // Sombra blanca para un efecto elevado
            spreadRadius: -3,
            blurRadius: 10,
            offset: Offset(-3, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 30.0,
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                message: doctorName.toUpperCase(),
                child: Text(
                  doctorName.length > 25
                      ? '${doctorName.substring(0, 25)}...'
                      : doctorName,
                  style:
                      style.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(specialty,
                  style: style.bodySmall?.copyWith(color: Colors.black54)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.calendar_today, color: Colors.black54, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    appointmentDate,
                    style:
                        style.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16.0),
                  Icon(Icons.access_time, color: Colors.black54, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(appointmentTime,
                      style: style.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.5), // Sombra gris semitransparente
                            spreadRadius: 5, // Extensión de la sombra
                            blurRadius: 15, // Difuminado de la sombra
                            offset:
                                Offset(4, 4), // Posición de la sombra (x, y)
                          ),
                          BoxShadow(
                            color: Colors
                                .white, // Sombra blanca para un efecto elevado
                            spreadRadius: -3,
                            blurRadius: 10,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewDetailsHistorico(cita: cita)),
                          );
                        },
                        child: Text('Ver proceso',
                            style:
                                style.bodySmall?.copyWith(color: Colors.white)),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => darkTeal),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
