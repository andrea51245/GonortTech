import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/carrusel/1.png',
      'assets/carrusel/2.png',
      'assets/carrusel/3.png',
      'assets/carrusel/4.png',
      'assets/carrusel/6.png',
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CarouselSlider.builder(
                  itemCount: imgList.length,
                  itemBuilder: (context, index, realIdx) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          imgList[index],
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height,
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.85,
                          left: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                            onPressed: () {
                              final routeName = screenRoutes[index];
                              if (routeName != null) {
                                Navigator.pushNamed(context, routeName);
                              } else {
                                print(
                                    'No se encontró una ruta para el índice $index');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 136, 214)
                                      .withOpacity(0.9),
                              minimumSize: const Size(120, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Ver más',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: CustomSection(),
              ),
              const SliverToBoxAdapter(
                child: ZoomableImageSection(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: Image.asset(
                      'assets/UTT.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Aquí agregas el footer como un SliverToBoxAdapter
              const SliverToBoxAdapter(
                child: FooterSection(),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: AppBar(
                    title: Image.asset(
                      'assets/logo_negro.png', // Ruta del logo
                      height:
                          40, // Ajusta el tamaño del logo según sea necesario
                      fit: BoxFit
                          .contain, // Asegura que el logo se ajuste correctamente
                    ),
                    centerTitle: true,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.9),
                    elevation: 0,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/Gonortech_logotipo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'catalogo');
                        },
                        child: const Text(
                          'Productos',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'model');
                        },
                        child: const Text(
                          'Visor 3D',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.account_circle,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {
                          Navigator.pushNamed(context, 'listview1');
                        },
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

// Define FooterSection aquí como ya tienes en tu código
class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      padding: const EdgeInsets.all(20.0),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PRODUCTOS',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  Text('Teléfonos',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Wearables',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('PC',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Tablets',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Accesorios',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Audio',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SERVICIOS',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  Text('Soporte Técnico',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Centro de Reparación',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Política de Garantía',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Actualización de Software',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SOPORTE',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  Text('Centro de Ayuda',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Contáctanos',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Noticias',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                  Text('Distribuidores Autorizados',
                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            '© 2024 GONORTECH. Todos los derechos reservados.',
            style: TextStyle(color: Color.fromARGB(137, 0, 0, 0), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// Incluye también el CustomSection y el ZoomableImageSection si es necesario.

class CustomSection extends StatelessWidget {
  const CustomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
        children: [
          _buildFeatureCard(
            'Fundas de diferentes diseños',
            'Diseños atractivos e innovadores',
            'assets/Tarjetas/tarjeta.png',
          ),
          _buildFeatureCard(
            'Audífonos con canelación de ruido',
            'Diseño amigable y varios colores',
            'assets/Tarjetas/audifonos.png',
          ),
          _buildFeatureCard(
            'Cableria genérico y original',
            'Multiples entradas de carga',
            'assets/Tarjetas/cables.png',
          ),
          _buildFeatureCard(
            'Cuerpos de cristal Kunlun Glass',
            'Mayor capacidad de resistencia a arañazos y caídas',
            'assets/Tarjetas/cristal.png',
          ),
          _buildFeatureCard(
            'Cristales gruesos',
            'Comodos y sin peso adicional',
            'assets/Tarjetas/cristal2.png',
          ),
          _buildFeatureCard(
            'Fundas de uso rudo',
            'Aguante sobrenatural para protección móvil',
            'assets/Tarjetas/tarjeta2.png',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, String subtitle, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
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

class ZoomableImageSection extends StatelessWidget {
  const ZoomableImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/carrusel/1.png',
      'assets/carrusel/2.png',
      'assets/carrusel/3.png',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return MouseRegion(
            onEnter: (_) {},
            onExit: (_) {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              transform: Matrix4.identity()..scale(1.1),
            ),
          );
        },
      ),
    );
  }
}

final Map<int, String> screenRoutes = {
  0: 'catalogo', // Ruta para el primer slide
  1: 'catalogo', // Ruta para el segundo slide
  2: 'catalogo', // Ruta para el tercer slide
  3: 'catalogo', // Ruta para el tercer slide
  4: 'catalogo', // Ruta para el tercer slide
  5: 'model',
  6: 'model', // Visor 3D
  // Agrega más rutas según sea necesario
};
