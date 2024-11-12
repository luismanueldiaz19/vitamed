import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/screens/folder_screen_doctors/screen_details_doctor.dart';

import '../../../models/doctor.dart';
import '../../../providers/provider_doctor.dart';

class DoctorCard extends StatefulWidget {
  final Doctor doctor;

  const DoctorCard({required this.doctor, Key? key}) : super(key: key);

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // isFavorite = widget.doctor.isFavorite ?? false;
  }

  void toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await Provider.of<ProviderDoctor>(context, listen: false)
          .addDoctorFavorite(widget.doctor.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      color: Colors.transparent,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              print(widget.doctor.toJson());
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ScreenDetailDoctor(doctor: widget.doctor)),
              );
            },
            child: Stack(
              children: [
                // CircleAvatar(
                //   backgroundImage:
                //       NetworkImage(widget.doctor.imageProfile ?? ''),
                //   radius: 30.0,
                // ),
                // Imagen de doctor
                Hero(
                  tag: widget.doctor.id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: widget.doctor.imageProfile ?? 'N/A',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),

                    // Image.network(
                    //   widget.doctor.imageProfile ?? 'N/A',
                    //   height: 150,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: toggleFavorite),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Calificación con estrellas y número de consultas
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      widget.doctor.star.toString(),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '(120)', // Número de consultas
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // Nombre del doctor
                Text(
                  widget.doctor.nombre != null &&
                          widget.doctor.nombre!.length > 20
                      ? '${widget.doctor.nombre?.substring(0, 20)}...'
                      : widget.doctor.nombre ?? 'N/A',
                  style:
                      style.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                // Especialidad
                Text(
                  widget.doctor.especialidad != null &&
                          widget.doctor.especialidad!.length > 15
                      ? '${widget.doctor.especialidad?.substring(0, 15)}...'
                      : widget.doctor.especialidad ?? 'Error',
                  style: style.bodyMedium?.copyWith(color: Colors.grey[700]),
                ),
                SizedBox(height: 4),
                // Centro médico
                Text(
                  widget.doctor.centro != null &&
                          widget.doctor.centro!.length > 15
                      ? '${widget.doctor.centro?.substring(0, 15)}...'
                      : widget.doctor.centro ?? 'Error',
                  style: style.bodySmall?.copyWith(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
