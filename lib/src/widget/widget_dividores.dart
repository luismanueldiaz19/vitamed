import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MyWidgetDivisores extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;

  const MyWidgetDivisores({
    Key? key,
    this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title ?? 'N/A', style: fontTitle),
          TextButton(
            onPressed: onPressed,
            child: Row(
              children: [
                Text('Ver todos',
                    style: fontBody.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: style.labelMedium?.fontSize,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
