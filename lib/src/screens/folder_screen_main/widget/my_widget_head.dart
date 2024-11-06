import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';

class MyWidgetHead extends StatelessWidget {
  const MyWidgetHead({super.key, this.currenUser});
  final User? currenUser;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bienvenido',
                        style: fontTitle.copyWith(
                            fontSize: style.titleLarge?.fontSize)),
                    Text('${currenUser?.displayName}', style: fontBody)
                  ],
                ),
              )
            ],
          ),
          CustomTextField(
              icon: Icons.search,
              labelText: 'Buscar',
              onChanged: (value) {},
              enabled: false),
        ],
      ),
    );
  }
}
