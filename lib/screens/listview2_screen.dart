import 'package:flutter/material.dart';

class Listview2Screen extends StatelessWidget {
  const Listview2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitamos el debug banner
      title: 'Panel de Administrador',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 29, 29, 29)),
        useMaterial3: true,
      ),
      home: const AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(200), // Altura personalizada del AppBar
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 29, 29, 29),
                  Color.fromARGB(255, 29, 29, 29)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.admin_panel_settings, size: 80, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'Panel de Administrador',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          elevation: 10,
          shadowColor: Colors.black54,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            const SizedBox(height: 20),
            AdminOption(
              icon: Icons.inventory_2,
              title: 'Gestionar Productos',
              subtitle: 'Añadir, modificar o eliminar productos',
              onTap: () {
                // Acción para gestionar productos
              },
            ),
            const SizedBox(height: 20),
            AdminOption(
              icon: Icons.work,
              title: 'Trabajos',
              subtitle: 'Revisar y gestionar trabajos',
              onTap: () {
                // Acción para revisar trabajos
              },
            ),
            const SizedBox(height: 20),
            AdminOption(
              icon: Icons.logout,
              title: 'Cerrar Sesión',
              subtitle: 'Salir del panel de administración',
              onTap: () {
                // Acción para cerrar sesión
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AdminOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AdminOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      shadowColor: Colors.black26,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 0, 0, 0)),
        onTap: onTap,
      ),
    );
  }
}
