import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  final String nombre;
  final String marca;
  final String modelo;
  final String categoria;
  final double precio;
  final String imagenUrl;
  final String descripcion;
  final String estado;
  final String color;

  Producto({
    required this.nombre,
    required this.marca,
    required this.modelo,
    required this.categoria,
    required this.precio,
    required this.imagenUrl,
    required this.descripcion,
    required this.estado,
    required this.color,
  });

  factory Producto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data(); 

    return Producto(
      nombre: data?['name'] ?? '',
      marca: data?['brand'] ?? '',
      modelo: data?['model'] ?? '',
      categoria: data?['category'] ?? '',
      precio: data?['price']?.toDouble() ?? 0.0,
      imagenUrl: data?['image_url'] ?? '',
      descripcion: data?['description'] ?? '',
      estado: data?['status'] ?? '',
      color: data?['color'] ?? '',
    );
  }

  static where(Function(dynamic producto) param0) {}
}
