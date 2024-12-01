import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vitamed/src/widgets/validar_screen_available.dart';

import '../../models/cita.dart';
import '../../models/historico.dart';
import '../../widget/card_historico_record.dart';

class ViewDetailsHistorico extends StatefulWidget {
  const ViewDetailsHistorico({Key? key, this.cita}) : super(key: key);
  final Cita? cita;
  @override
  _ViewDetailsHistoricoState createState() => _ViewDetailsHistoricoState();
}

class _ViewDetailsHistoricoState extends State<ViewDetailsHistorico> {
  final DatabaseReference _historicoDetailsRef =
      FirebaseDatabase.instance.ref().child('historial_medicos');
  List<Historico> _doctorList = [];

  getHistorico() async {
    // Consulta para buscar recetas del usuario específico
    final Query query =
        _historicoDetailsRef.orderByChild('citaId').equalTo(widget.cita?.id);

    final DatabaseEvent event = await query.once();
    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      // Convierte el mapa en una lista
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      print('data : ${jsonEncode(data)}');

      _doctorList = data.entries.map((entry) {
        // entry.key es el ID

        entry.value['id'] = entry.key as String;
        return Historico.fromJson(entry.value as Map<dynamic, dynamic>);
      }).toList();
      // _doctorListFilter = _doctorList;
      setState(() {});
    } else {
      print(widget.cita?.toJson());
      print("No se encontraron datos.");
    }
  }

  @override
  void initState() {
    super.initState();
    getHistorico();
  }

//  -OBrqGTSUtN3oerW6KHs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Proceso de consulta'),
          backgroundColor: Colors.white),
      body: ValidarScreenAvailable(
        mobile: ListView.builder(
          itemCount: _doctorList.length,
          itemBuilder: (BuildContext context, int index) {
            Historico item = _doctorList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ZoomIn(
                  curve: Curves.elasticInOut,
                  child: CardHistoricoRecord(historico: item)),
            );
          },
        ),
      ),
    );
  }
}
