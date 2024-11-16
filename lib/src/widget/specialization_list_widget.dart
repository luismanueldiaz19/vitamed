// specialization_list_widget

import 'package:flutter/material.dart';
import 'package:vitamed/src/widget/specialization_card.dart';

class SpecializationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 100,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              SpecializationCard(
                icon: Icons.favorite, // Cardiología
                specializationName: 'Cardiología',
                doctorCount: 258,
              ),
              const SizedBox(width: 10),
              SpecializationCard(
                icon: Icons.visibility, // Oftalmología
                specializationName: 'Oftalmología',
                doctorCount: 187,
              ),
              const SizedBox(width: 10),
              SpecializationCard(
                icon: Icons.local_hospital, // Neurología
                specializationName: 'Neurología',
                doctorCount: 142,
              ),
              const SizedBox(width: 10),
              SpecializationCard(
                icon: Icons.pregnant_woman, // Ginecología
                specializationName: 'Ginecología',
                doctorCount: 320,
              ),
              const SizedBox(width: 10),
              SpecializationCard(
                icon: Icons.child_care, // Pediatría
                specializationName: 'Pediatría',
                doctorCount: 195,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
