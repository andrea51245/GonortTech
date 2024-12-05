import 'package:flutter/material.dart';
import 'producto_model.dart';

class ProductoDetalleDialog extends StatelessWidget {
  final Producto producto;

  const ProductoDetalleDialog({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(producto.nombre),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Image.asset(producto.imagenUrl),  // Asegúrate de que el producto tenga una imagen válida
            const SizedBox(height: 10),
            Text('Categoría: ${producto.categoria}'),
            Text('Marca: ${producto.marca}'),
            Text('Modelo: ${producto.modelo}'),
            Text('Descripción: ${producto.descripcion}'),
            Text('Precio: \$${producto.precio.toString()}'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}