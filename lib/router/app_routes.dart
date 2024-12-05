import 'package:fl_components/screens/carrito_model.dart';
import 'package:fl_components/screens/catalogo_productos%20.dart';
// Asegúrate de que la ruta sea correcta
import 'package:flutter/material.dart';
import 'package:fl_components/models/models.dart';
import 'package:fl_components/screens/screens.dart';

import 'package:fl_components/screens/model_viewer_screen.dart'; // Asegúrate de importar la pantalla correcta

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    MenuOption(
      route: 'listview1',
      name: 'Inicio de Sesión',
      screen: Login(),
      icon: Icons.login,
    ),
    MenuOption(
      route: 'listview2',
      name: 'Administrador',
      screen: const Listview2Screen(),
      icon: Icons.admin_panel_settings,
    ),
    MenuOption(
      route: 'catalogo',
      name: 'Productos',
      screen: CatalogoProductos(carrito: Carrito()),
      icon: Icons.shopping_cart,
    ),
    // Nueva opción para el visor 3D
    MenuOption(
      route: 'model', // Ruta para el visor 3D
      name: 'Visor 3D',
      screen: const ModelViewerScreen(), // La pantalla que muestra el modelo 3D
      icon: Icons.image, // Cambia el ícono a uno apropiado
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    // Las demás rutas existentes
    'listview1': (BuildContext context) => Login(),
    'listview2': (BuildContext context) => const Listview2Screen(),
    'catalogo': (BuildContext context) => CatalogoProductos(carrito: Carrito()),
    'model': (BuildContext context) => const ModelViewerScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
