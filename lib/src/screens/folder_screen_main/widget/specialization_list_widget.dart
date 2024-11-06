// specialization_list_widget

import 'package:flutter/material.dart';
import 'package:vitamed/src/screens/folder_screen_main/widget/specialization_card.dart';

class SpecializationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GridView.count(
        crossAxisCount: 3, // Para mostrar 2 columnas
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: const EdgeInsets.all(16.0),
        children: const [
          SpecializationCard(
            icon: Icons.favorite, // Cardiología
            specializationName: 'Cardiología',
            doctorCount: 258,
          ),
          SpecializationCard(
            icon: Icons.visibility, // Oftalmología
            specializationName: 'Oftalmología',
            doctorCount: 187,
          ),
          SpecializationCard(
            icon: Icons.local_hospital, // Neurología
            specializationName: 'Neurología',
            doctorCount: 142,
          ),
          SpecializationCard(
            icon: Icons.pregnant_woman, // Ginecología
            specializationName: 'Ginecología',
            doctorCount: 320,
          ),
          SpecializationCard(
            icon: Icons.child_care, // Pediatría
            specializationName: 'Pediatría',
            doctorCount: 195,
          ),
        ],
      ),
    );
  }
}
