import 'package:flutter/material.dart';

import 'package:fl_components/widgets/widgets.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Card Widget'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: const [
            CustomCardType1(),
            SizedBox(height: 10),
            CustomCardType2(
                imageUrl:
                    'https://photographylife.com/wp-content/uploads/2017/01/What-is-landscape-photography.jpg'),
            SizedBox(height: 20),
            CustomCardType2(
              imageUrl:
                  'https://cdn1.epicgames.com/ue/product/Screenshot/04-1920x1080-d39d5f7af4e17b162383cdf38ce97858.jpg?resize=1&w=1920',
            ),
            SizedBox(height: 20),
            CustomCardType2(
                name:
                    'Misión:Brindar soluciones accesibles y de alta calidad en la venta de accesorios y reparaciones de celulares, ofreciendo una experiencia eficiente y segura a través de plataformas digitales innovadoras, que permitan a nuestros clientes obtener productos y servicios confiables desde cualquier lugar. Visión: Ser líderes en el mercado digital de accesorios y reparaciones de celulares, reconocidos por nuestra calidad, confiabilidad y capacidad de adaptación a las nuevas tecnologías, ofreciendo un servicio excepcional que combine innovación y cercanía con nuestros clientes en cada interacción.',
                imageUrl:
                    'https://photographylife.com/wp-content/uploads/2016/06/Mass.jpg'),
            SizedBox(height: 100),
          ],
        ));
  }
}
