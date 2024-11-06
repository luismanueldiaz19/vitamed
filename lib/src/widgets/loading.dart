import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom(
      {super.key, this.text = 'Verificando ......', this.isLoading = true});
  final String? text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElasticIn(
              curve: Curves.elasticInOut,
              child: Image.asset('assets/imagen/sin-datos.png', scale: 5)),
          SlideInLeft(
              curve: Curves.elasticInOut, child: Text(text ?? 'No hay datos')),
        ],
      ),
    );
  }
}
