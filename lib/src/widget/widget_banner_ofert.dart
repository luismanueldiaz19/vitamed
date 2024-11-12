import 'package:flutter/material.dart';

import '../utils/constants.dart';

class WidgetBannerOfert extends StatefulWidget {
  const WidgetBannerOfert({super.key});

  @override
  State<WidgetBannerOfert> createState() => _WidgetBannerOfertState();
}

class _WidgetBannerOfertState extends State<WidgetBannerOfert> {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return SizedBox(
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                width: 150,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        deepTeal.withOpacity(0.7),
                        brightAqua.withOpacity(0.7)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),

                    // boxShadow: [shadow],
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '25 % OFF',
                        style: fontBody.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: style.titleLarge?.fontSize,
                        ),
                      ),
                      Text('to visit an ophthalmologist',
                          style:
                              style.bodySmall?.copyWith(color: Colors.black54)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.medical_services_outlined, size: 25),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
