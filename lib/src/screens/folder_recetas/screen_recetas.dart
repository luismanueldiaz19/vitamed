import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/providers/provider_usuario.dart';
import 'package:vitamed/src/widgets/loading.dart';
import '../../services/notification_service.dart';
import '../../utils/constants.dart';
import '../../models/receta.dart';
import '../../providers/provider_recetas.dart';
import 'receta_card.dart';

class ScreenRecetas extends StatefulWidget {
  const ScreenRecetas({super.key});

  @override
  State<ScreenRecetas> createState() => _ScreenRecetasState();
}

class _ScreenRecetasState extends State<ScreenRecetas> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderRecetas>(context, listen: false).fetchRecet();
    });
  }

  @override
  Widget build(BuildContext context) {
    final listRecetas = context.watch<ProviderRecetas>().listReceta;
    final style = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: kTextTabBarHeight),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Indicaciones',
                      style: fontTitle.copyWith(
                          fontSize: style.titleLarge?.fontSize)),
                  Text('Que te mejores ..!',
                      style: fontBody.copyWith(color: Colors.black54))
                ],
              ),
            )
          ],
        ),
        listRecetas.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: listRecetas.length,
                  itemBuilder: (BuildContext context, int index) {
                    Receta item = listRecetas[index];
                    return RecetaCard(
                      receta: item.toJson(),
                      onPressed: () => updateRecetaStatus(item.id),
                      onPressedProgramar: () => {},
                    );
                  },
                ),
              )
            : Expanded(
                child: Center(
                    child: LoadingCustom(
                        isLoading: false, text: 'No hay Indicaciones')),
              ),
      ],
    );
  }

  updateRecetaStatus(recetaId) async {
    await showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            title: Text('Confirmar'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            content: Text(
                '¿Estás seguro de que deseas marcar como terminado esta indicación.?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Cerrar el diálogo sin hacer nada
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    Provider.of<ProviderRecetas>(context, listen: false)
                        .updateRecetaStatus(recetaId);
                    Navigator.of(context)
                        .pop(); // Crear el mensaje de la notificación personalizada
                    String notificationBody =
                        'acaba de finalizar un tratamiento';
                    await NotificationService.showNotificacion(
                      title: 'Hasta Luego!, que te mejores',
                      body: notificationBody,
                      summary: '¡Finalizaste tu tratamiento!',
                      notificationLayout: NotificationLayout.Messaging,
                    );
                  },
                  child:
                      Text('Confirmar', style: TextStyle(color: Colors.green))),
            ],
          );
        });
  }
}
