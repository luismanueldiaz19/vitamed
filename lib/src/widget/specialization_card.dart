import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SpecializationCard extends StatelessWidget {
  final IconData icon;
  final String specializationName;
  final int doctorCount;

  const SpecializationCard({
    Key? key,
    required this.icon,
    required this.specializationName,
    required this.doctorCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: aquaTeal),
          const SizedBox(height: 8.0),
          Text(
            specializationName,
            style: style.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.0),
          Text(
            '$doctorCount Doctores',
            style: style.bodySmall?.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
