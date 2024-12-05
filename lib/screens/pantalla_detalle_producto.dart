import 'package:flutter/material.dart';
import 'producto_model.dart';

class ProductoDetalleScreen extends StatelessWidget {
  final Producto producto;

  const ProductoDetalleScreen({Key? key, required this.producto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen a la derecha
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                producto.imagenUrl,
                fit: BoxFit.cover,
                width: double.infinity, // Ancho completo
                height: 250, // Alto fijo de la imagen
              ),
            ),
            const SizedBox(height: 16),
            // Información del producto
            Text(
              producto.nombre,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Categoría: ${producto.categoria}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Marca: ${producto.marca}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Modelo: ${producto.modelo}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Precio: \$${producto.precio.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 76, 228, 84),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Descripción: ${producto.descripcion}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 76, 228, 84),
              ),
              onPressed: () {
                // Agregar al carrito (esto puede ser modificado según tu lógica)
              },
              child: const Text('Agregar al Carrito'),
            ),
          ],
        ),
      ),
    );
  }
}
