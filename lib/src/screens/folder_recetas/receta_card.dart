import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vitamed/src/utils/constants.dart';

class RecetaCard extends StatelessWidget {
  final Map<String, dynamic> receta;

  RecetaCard({required this.receta, required this.onPressed});
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(receta['centro'] ?? 'Centro no especificado',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          // SizedBox(height: 8.0),
          Text('Doctor: ${receta['name_doctor']}',
              style: TextStyle(fontSize: 16.0)),
          Text('${receta['especialidad']}',
              style: TextStyle(fontSize: 16.0, color: Colors.orange)),
          Text('Registrado: ${receta['date_cita']}',
              style: TextStyle(fontSize: 16.0)),
          const Divider(),
          SizedBox(height: 8.0),
          Text('Indicaciones: ${receta['indicaciones']}',
              style: TextStyle(fontSize: 16.0)),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(Icons.circle_notifications_outlined, color: deepTeal),
                  Text('${receta['frecuencia']} Al Dias',
                      style: TextStyle(fontSize: 16.0)),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                  Text('Por : ${receta['cantidad_dias']} Dias',
                      style: TextStyle(fontSize: 16.0)),
                ],
              )
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: onPressed,
                  child: Text('Terminar', style: TextStyle(color: Colors.red))),
              if (receta['path_imagen'] != 'N/A')
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      _showImageDialog(context, receta['path_imagen']);
                    },
                    icon: Icon(Icons.image, color: Colors.blue),
                    label: Text(
                      'Ver Imagen',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: downloadProgress.progress,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                          Text('Cargando imagen Espere ...')
                        ],
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No se pudo cargar la imagen.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ), // SizedBox(
              //   height: 250,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.vertical(
              //       top: Radius.circular(12.0),
              //     ),
              //     child: CachedNetworkImage(
              //       imageUrl: imageUrl,
              //       imageBuilder: (context, imageProvider) => Container(
              //         height: 200,
              //         decoration: BoxDecoration(
              //           borderRadius:
              //               BorderRadius.vertical(top: Radius.circular(10)),
              //           image: DecorationImage(
              //               image: imageProvider, fit: BoxFit.cover),
              //         ),
              //       ),
              //       progressIndicatorBuilder:
              //           (context, url, downloadProgress) => Center(
              //         child: SizedBox(
              //           width: 50,
              //           height: 50,
              //           child: CircularProgressIndicator(
              //             strokeWidth: 2,
              //             value: downloadProgress
              //                 .progress, // Progreso entre 0.0 y 1.0
              //             valueColor:
              //                 AlwaysStoppedAnimation<Color>(Colors.blue),
              //           ),
              //         ),
              //       ),
              //       placeholder: (context, url) => Center(
              //         child: SizedBox(
              //           width: 50,
              //           height: 50,
              //           child: CircularProgressIndicator(
              //             strokeWidth: 2,
              //             valueColor:
              //                 AlwaysStoppedAnimation<Color>(Colors.blue),
              //           ),
              //         ),
              //       ),
              //       errorWidget: (context, url, error) => Padding(
              //           padding: const EdgeInsets.all(16.0),
              //           child: Text('No se pudo cargar la imagen.',
              //               style: TextStyle(color: Colors.red))),
              //     ),
              //   ),
              // ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cerrar',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
