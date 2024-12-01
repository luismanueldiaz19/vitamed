import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vitamed/src/screens/folder_recetas/receta_card.dart';

import '../../models/receta.dart';

class DialogViewReceta extends StatefulWidget {
  const DialogViewReceta({Key? key, this.citaId}) : super(key: key);
  final String? citaId;
  @override
  _DialogViewRecetaState createState() => _DialogViewRecetaState();
}

class _DialogViewRecetaState extends State<DialogViewReceta> {
  List<Receta> _ListReceta = [];
  Future<void> fetchRecet() async {
    // debugPrint('fetchRecetas para usuario ${_authService.currentUser!.uid}');

    // Referencia al nodo de recetas
    final DatabaseReference recetasRef =
        FirebaseDatabase.instance.ref().child('recetas');

    // Consulta para buscar recetas del usuario específico
    final Query query =
        recetasRef.orderByChild('citaId').equalTo(widget.citaId);

    final DatabaseEvent event = await query.once();
    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      // Filtrar las recetas activas después de obtener los datos
      _ListReceta = data.entries.map((entry) {
        return Receta.fromJson(
            entry.key as String, entry.value as Map<dynamic, dynamic>);
      }).toList();

      print('Recetas filtradas: ${_ListReceta.length}');
    } else {
      print("No se encontraron recetas para el usuario ${widget.citaId}.");
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchRecet();
  }

  @override
  Widget build(BuildContext context) {
    return _ListReceta.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _ListReceta.map(
              (item) => RecetaCard(
                isRecord: true,
                onPressedProgramar: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Accion no permitida desde aqui'),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red));
                },
                receta: item.toJson(),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Accion no permitida desde aqui'),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ).toList(),
          )
        : Center(
            child: Text(
            'Sin receta registrada!',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ));
  }
}
