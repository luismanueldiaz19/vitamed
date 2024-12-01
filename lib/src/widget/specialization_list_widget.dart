// specialization_list_widget

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/models/doctor.dart';
import 'package:vitamed/src/widget/specialization_card.dart';

import '../providers/provider_doctor.dart';

class SpecializationsList extends StatefulWidget {
  @override
  State<SpecializationsList> createState() => _SpecializationsListState();
}

class _SpecializationsListState extends State<SpecializationsList> {
  @override
  Widget build(BuildContext context) {
    // final doctorList =
    //     Provider.of<ProviderDoctor>(context, listen: true).doctorListFilter;
    final providerData = Provider.of<ProviderDoctor>(context, listen: false);

    final pick = Provider.of<ProviderDoctor>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
          height: 75,
          child: Row(
            children: [
              pick.especialidadPicked.isNotEmpty
                  ? BounceInDown(
                      curve: Curves.elasticInOut,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => providerData.normalizar(),
                            icon: Icon(Icons.close, color: Colors.red),
                          ),
                          Text('Quitar',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.red.shade200)),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: Doctor.getUniqueCategoria(providerData.doctorList)
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                providerData.selectDoctorEspecialidad(item);
                              },
                              child: ZoomIn(
                                curve: Curves.elasticInOut,
                                child: SpecializationCard(
                                  colors: pick.especialidadPicked == item
                                      ? Colors.white
                                      : Colors.grey.shade200,
                                  icon: EspecialidadesIconos
                                      .getIconForEspecialidad(
                                          item), // Cardiología
                                  specializationName: item,
                                  doctorCount: providerData.doctorList
                                      .where((element) =>
                                          element.especialidad == item)
                                      .toList()
                                      .length
                                      .toInt(),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          )

          //  SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: const [
          //       SpecializationCard(
          //         icon: Icons.favorite, // Cardiología
          //         specializationName: 'Cardiología',
          //         doctorCount: 258,
          //       ),
          //       const SizedBox(width: 10),
          //       SpecializationCard(
          //         icon: Icons.visibility, // Oftalmología
          //         specializationName: 'Oftalmología',
          //         doctorCount: 187,
          //       ),
          //       const SizedBox(width: 10),
          //       SpecializationCard(
          //         icon: Icons.local_hospital, // Neurología
          //         specializationName: 'Neurología',
          //         doctorCount: 142,
          //       ),
          //       const SizedBox(width: 10),
          //       SpecializationCard(
          //         icon: Icons.pregnant_woman, // Ginecología
          //         specializationName: 'Ginecología',
          //         doctorCount: 320,
          //       ),
          //       const SizedBox(width: 10),
          //       SpecializationCard(
          //         icon: Icons.child_care, // Pediatría
          //         specializationName: 'Pediatría',
          //         doctorCount: 195,
          //       ),
          //       const SizedBox(width: 10),
          //     ],
          //   ),
          // ),

          ),
    );
  }

  getRandomIcon() {
    List<IconData> icons = [
      Icons.local_hospital,
      Icons.favorite,
      Icons.visibility,
      Icons.pregnant_woman,
      Icons.child_care,
    ];

    // Generar un índice aleatorio
    int randomIndex = Random().nextInt(icons.length);

    // Retornar el ícono en el índice aleatorio
    return icons[randomIndex];
  }
}
