import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom(
      {super.key,
      this.text = 'Verificando ......',
      this.isLoading = true,
      this.image = 'assets/imagen/sin-datos.png'});
  final String? text;
  final bool isLoading;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElasticIn(
              curve: Curves.elasticInOut,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.asset(image!, scale: 5))),
          SlideInLeft(
              curve: Curves.elasticInOut, child: Text(text ?? 'No hay datos')),
        ],
      ),
    );
  }
}
