import 'package:flutter/material.dart';

import '../models/historico.dart';
import '../screens/folder_recetas/dialog_view_receta.dart';
import '../utils/constants.dart';

class CardHistoricoRecord extends StatelessWidget {
  const CardHistoricoRecord({Key? key, required this.historico})
      : super(key: key);
  final Historico historico;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Container(
      // elevation: 5, // Sombra
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.grey.withOpacity(0.5), // Sombra gris semitransparente
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
          color: Colors.white),

      // shadowColor: Colors.black54,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre y Edad
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  historico.nombre ?? 'Sin nombre',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'Edad: ${historico.edad ?? "N/A"}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.black38),
            // Dirección
            Row(
              children: [
                Icon(Icons.home, color: Colors.green),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    historico.direccion ?? 'Dirección no especificada',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Teléfono
            Row(
              children: [
                Icon(Icons.phone, color: Colors.orange),
                const SizedBox(width: 10),
                Text(
                  historico.telefono ?? 'Sin teléfono',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Motivo de consulta
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.medical_services, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    historico.motivoConsulta ?? 'Sin motivo de consulta',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Diagnóstico
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.pending_actions, color: Colors.purple),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    historico.diagnostico ?? 'Sin diagnóstico',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Pruebas solicitadas',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            // Pruebas solicitadas
            if (historico.pruebasSolicitadas != null &&
                historico.pruebasSolicitadas!.isNotEmpty) ...[
              const Divider(color: Colors.black38),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.science, color: Colors.teal),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: historico.pruebasSolicitadas!
                          .map((prueba) => Text(
                                '- $prueba',
                                style: const TextStyle(fontSize: 14),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 10),
            Text('Examen físico',
                style: TextStyle(fontSize: 16, color: Colors.black54)),
            // Pruebas solicitadas
            if (historico.examenFisico != null) ...[
              const Divider(color: Colors.black38),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.route_rounded, color: Colors.brown),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(historico.examenFisico?.temperatura ?? ''),
                        Text(historico.examenFisico?.presionArterial ?? ''),
                        Text(historico.examenFisico?.frecuenciaCardiaca ?? ''),
                      ],
                    ),
                  ),
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
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return DialogViewReceta(
                                    citaId: historico.citaId);
                              });
                        },
                        child: Text('Ver Receta',
                            style:
                                style.bodySmall?.copyWith(color: Colors.white)),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => darkTeal),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ],
        ),
      ),
    );
  }
}
