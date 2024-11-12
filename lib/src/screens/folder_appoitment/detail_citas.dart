import 'package:flutter/material.dart';

import '../../models/cita.dart';

class DetailCita extends StatefulWidget {
  const DetailCita({super.key, this.cita});
  final Cita? cita;

  @override
  State<DetailCita> createState() => _DetailCitaState();
}

class _DetailCitaState extends State<DetailCita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Detalles de la cita'),
      ),
      body: Column(

        children: [


          
        ],
      ),
    );
  }
}
