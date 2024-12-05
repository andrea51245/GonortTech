// carrito_model.dart
import 'package:flutter/material.dart';
import 'producto_model.dart';

class Carrito with ChangeNotifier {
  final List<Producto> _productos = [];

  List<Producto> get productos => _productos;

  void agregarProducto(Producto producto) {
    _productos.add(producto);
    notifyListeners();
  }

  void eliminarProducto(Producto producto) {
    _productos.remove(producto);
    notifyListeners();
  }

  // Getter para calcular el precio total
  double get totalPrecio {
    return _productos.fold(0.0, (sum, item) => sum + item.precio);
  }
}
