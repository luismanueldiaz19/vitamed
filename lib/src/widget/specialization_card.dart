import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SpecializationCard extends StatelessWidget {
  final IconData icon;
  final String specializationName;
  final int doctorCount;
  final Color? colors;

  const SpecializationCard({
    Key? key,
    required this.icon,
    required this.specializationName,
    required this.doctorCount,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: colors ?? Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: aquaTeal),
          const SizedBox(height: 8.0),
          Tooltip(
            message: specializationName.toLowerCase(),
            child: Text(
              specializationName.toString().length > 10
                  ? '${specializationName.toString().substring(0, 10)} ..'
                  : specializationName.toString(),
              style: style.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            '$doctorCount Doctores',
            style:
                style.bodySmall?.copyWith(color: Colors.black54, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
