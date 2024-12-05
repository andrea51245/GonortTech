import 'package:flutter/material.dart';
import 'carrito_model.dart';

class PantallaCarrito extends StatefulWidget {
  final Carrito carrito;

  const PantallaCarrito({Key? key, required this.carrito}) : super(key: key);

  @override
  _PantallaCarritoState createState() => _PantallaCarritoState();
}

class _PantallaCarritoState extends State<PantallaCarrito> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            const BackButton(color: Colors.black), // Botón de regreso negro
        title: const Text(
          'Mi carrito de Compras',
          style: TextStyle(
            color: Colors.black, // Texto del título en negro
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white, // Fondo blanco
      ),
      backgroundColor: Colors.white, // Fondo del cuerpo blanco
      body: widget.carrito.productos.isEmpty
          ? const Center(
              child: Text(
                'Tu carrito está vacío',
                style: TextStyle(color: Colors.black), // Texto negro
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.carrito.productos.length,
                    itemBuilder: (context, index) {
                      final producto = widget.carrito.productos[index];
                      return ListTile(
                        leading: Image.asset(producto.imagenUrl),
                        title: Text(
                          producto.nombre,
                          style: const TextStyle(
                              color: Colors.black), // Texto negro
                        ),
                        subtitle: Text(
                          'Marca: ${producto.marca} - Modelo: ${producto.modelo}',
                          style: const TextStyle(
                              color: Colors.black), // Texto negro
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black, // Ícono negro
                          ),
                          onPressed: () {
                            setState(() {
                              widget.carrito.eliminarProducto(producto);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: \$${widget.carrito.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black, // Texto negro
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
