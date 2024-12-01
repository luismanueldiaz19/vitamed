import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vitamed/src/utils/constants.dart';

class RecetaCard extends StatelessWidget {
  final Map<String, dynamic> receta;
  bool? isRecord;
  RecetaCard(
      {required this.receta,
      required this.onPressed,
      required this.onPressedProgramar,
      this.isRecord = false});
  Function()? onPressed;
  Function()? onPressedProgramar;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, skyAquaLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(receta['centro'] ?? 'Centro no especificado',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),

          Text('Doctor: ${receta['name_doctor']}',
              style: TextStyle(fontSize: 16.0, color: Colors.black54)),
          Text('${receta['especialidad']}',
              style: TextStyle(fontSize: 16.0, color: Colors.black)),
          Text('Registrado: ${receta['date_cita']}',
              style: TextStyle(fontSize: 16.0, color: Colors.black45)),
          const Divider(color: Colors.black38),

          Text('Indicaciones: ${receta['indicaciones']}',
              style: TextStyle(fontSize: 16.0)),

          // Text('Indicaciones: ${receta['citaId']}',
          //     style: TextStyle(fontSize: 16.0)),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Column(
          //       children: [
          //         Icon(Icons.circle_notifications_outlined, color: deepTeal),
          //         Text('${receta['frecuencia']} Al Dias',
          //             style: TextStyle(fontSize: 16.0)),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Icon(Icons.wb_sunny_outlined, color: Colors.orange),
          //         Text('Por : ${receta['cantidad_dias']} Dias',
          //             style: TextStyle(fontSize: 16.0)),
          //       ],
          //     )
          //   ],
          // ),
          SizedBox(height: 8.0),
          if (receta['path_imagen'] != 'N/A')
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showImageDialog(context, receta['path_imagen']);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: receta['path_imagen'],
                      imageBuilder: (context, imageProvider) => Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Padding(
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
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
                  ),
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 15),
                child: TextButton.icon(
                  onPressed: onPressedProgramar,
                  label: Text('Programar'),
                  icon: Icon(Icons.timer),
                ),
              ),
              isRecord!
                  ? const SizedBox()
                  : Padding(
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
                            // BoxShadow(
                            //   color: Colors
                            //       .white, // Sombra blanca para un efecto elevado
                            //   spreadRadius: -3,
                            //   blurRadius: 10,
                            //   offset: Offset(-3, -3),
                            // ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: onPressed,
                          child: Text('Terminar',
                              style: style.titleSmall
                                  ?.copyWith(color: Colors.white)),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith(
                              (states) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.red),
                          ),
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
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12.0),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
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
        );
      },
    );
  }
}
