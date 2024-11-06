// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class CarruselDemo extends StatelessWidget {
//   final List<String>? imageList;
//   const CarruselDemo({super.key, this.imageList});

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 150.0,
//         autoPlay: true,
//         enlargeCenterPage: true,
//         aspectRatio: 16 / 9,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         viewportFraction: 0.3,
//       ),
//       items: imageList!
//           .map((item) => Container(
//                 margin: const EdgeInsets.all(5.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   image: DecorationImage(
//                     image: NetworkImage(item),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }
