import 'producto_model.dart';

class Carrito {
  final List<Producto> _productosEnCarrito = [];

  List<Producto> get productos => _productosEnCarrito;

  void agregarProducto(Producto producto) {
    _productosEnCarrito.add(producto);
  }

  void eliminarProducto(Producto producto) {
    _productosEnCarrito.remove(producto);
  }

  double get total => _productosEnCarrito.fold(0, (sum, item) => sum + item.precio);
}

