import 'package:flutter/material.dart';
import 'producto_model.dart';

class BusquedaProductoDelegate extends SearchDelegate {
  // Lista de productos para la búsqueda
  final List<Producto> productos;

  BusquedaProductoDelegate(this.productos, {required String hintText});

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Icono para limpiar el texto de búsqueda
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpia el texto de búsqueda
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Botón para regresar
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Cierra el buscador
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultados de búsqueda
    final resultados = productos.where((producto) {
      return producto.nombre.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (resultados.isEmpty) {
      return const Center(
        child: Text(
          'No se encontraron productos.',
          style: TextStyle(color: Colors.white), // Texto blanco en fondo negro
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      body: ListView.builder(
        itemCount: resultados.length,
        itemBuilder: (context, index) {
          final producto = resultados[index];
          return ListTile(
            leading: Image.asset(producto.imagenUrl, width: 50, height: 50),
            title: Text(producto.nombre,
                style: const TextStyle(color: Colors.white)),
            subtitle: Text(
              '\$${producto.precio.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.greenAccent),
            ),
            onTap: () {
              // Realiza una acción al seleccionar un producto
              close(context,
                  producto); // Cierra la búsqueda y selecciona el producto
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias mientras se escribe
    final sugerencias = productos.where((producto) {
      return producto.nombre.toLowerCase().startsWith(query.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      body: ListView.builder(
        itemCount: sugerencias.length,
        itemBuilder: (context, index) {
          final producto = sugerencias[index];
          return ListTile(
            leading: Image.asset(producto.imagenUrl, width: 50, height: 50),
            title: Text(producto.nombre,
                style: const TextStyle(color: Colors.white)),
            onTap: () {
              query = producto
                  .nombre; // Llena el texto de búsqueda con la sugerencia
              showResults(context); // Muestra los resultados de la búsqueda
            },
          );
        },
      ),
    );
  }
}
