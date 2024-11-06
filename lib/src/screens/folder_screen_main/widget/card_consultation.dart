import 'package:flutter/material.dart';

class CardConsultation extends StatelessWidget {
  final String imageUrl;
  final String doctorName;
  final String specialty;
  final String appointmentDate;
  final String appointmentTime;

  const CardConsultation({
    Key? key,
    required this.imageUrl,
    this.doctorName = 'Dr. Alexander Vasilenko',
    this.specialty = 'Especialidades',
    this.appointmentDate = '24 Sept',
    this.appointmentTime = '19:30',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54), // Borde estilo Outline
        borderRadius: BorderRadius.circular(10.0),
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
              Text(
                doctorName,
                style: style.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
            ],
          ),
        ],
      ),
    );
  }
}
