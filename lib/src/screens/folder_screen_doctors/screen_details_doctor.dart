import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vitamed/src/models/doctor.dart';
import 'package:vitamed/src/screens/folder_appoitment/add_appoitment.dart';

import '../../utils/constants.dart';

class ScreenDetailDoctor extends StatefulWidget {
  const ScreenDetailDoctor({super.key, this.doctor});
  final Doctor? doctor;

  @override
  State<ScreenDetailDoctor> createState() => _ScreenDetailDoctorState();
}

class _ScreenDetailDoctorState extends State<ScreenDetailDoctor> {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Mi Doctor'),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: widget.doctor!.id.toString(),
            child: Container(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.doctor!.imageProfile ?? 'N/A',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 250,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Positioned(
                    top: kToolbarHeight / 2,
                    left: 15,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: kToolbarHeight,
                  //   right: 15,
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(
                  //         widget.doctor!.isFavorite!
                  //             ? Icons.favorite
                  //             : Icons.favorite_border,
                  //         color: widget.doctor!.isFavorite!
                  //             ? Colors.red
                  //             : Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          widget.doctor!.star.toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(120) Review', // Número de consultas
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Calificación con estrellas y número de consultas

                        SizedBox(height: 4),
                        // Nombre del doctor
                        Text(widget.doctor!.nombre ?? 'N/A',
                            style: style.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        // Especialidad
                        Text(
                          widget.doctor?.especialidad ?? 'Error',
                          style: style.bodyMedium
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                        SizedBox(height: 4),
                        // Centro médico
                        Text(
                          widget.doctor!.centro ?? 'Error',
                          style: style.bodySmall
                              ?.copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text("Información", style: fontTitle),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(widget.doctor?.informacion ?? 'N/A'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text("Jornadas de trabajos", style: fontTitle),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(widget.doctor?.horarios ?? 'N/A'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text("Seguros Medicos", style: fontTitle),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 6.0,
                      children: widget.doctor!.seguros!
                          .map((e) => Chip(
                                avatar: Icon(Icons.check_circle,
                                    color: Colors.green.shade400, size: 16),
                                backgroundColor: Colors.white,
                                elevation: 2,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                label: Text(
                                  e,
                                  style: style.bodySmall
                                      ?.copyWith(color: Colors.black87),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddAppoitment(doctor: widget.doctor!),
                    ),
                  );
                },
                child: Text(
                  'Cita'.toUpperCase(),
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
    );
  }
}
