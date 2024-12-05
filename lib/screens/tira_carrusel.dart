import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TiraCarousel extends StatelessWidget {
  const TiraCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/Lanzamientos/1.jpg',
      'assets/Lanzamientos/2.jpg',
      'assets/Lanzamientos/3.jpg',
      'assets/Lanzamientos/4.jpg',
      'assets/Lanzamientos/5.jpg',
      'assets/Lanzamientos/6.jpg',
      'assets/Lanzamientos/7.jpg',
      'assets/Lanzamientos/8.jpg',
    ];

    return SizedBox(
      height: 100, // Ajusta la altura del carrusel aquí
      child: CarouselSlider.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index, realIdx) {
          return Container(
            // Se eliminó el margen o se redujo
            margin:
                const EdgeInsets.symmetric(horizontal: 2.0), // Menos separación
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imgList[index],
                fit: BoxFit.cover,
                width: 200, // Ajusta el ancho aquí
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 100, // Altura del carrusel
          aspectRatio: 2.0,
          viewportFraction: 0.2, // Controla cuánto se ve de cada item
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }
}
