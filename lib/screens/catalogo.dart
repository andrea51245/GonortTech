import 'package:flutter/material.dart';

void main() {
  runApp(const Catalogo());
}

class Catalogo extends StatelessWidget {
  const Catalogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantalla de Productos',
      home: ProductsScreen(),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Producto 1',
      price: 29.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Producto 2',
      price: 19.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Producto 3',
      price: 49.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(product.imageUrl),
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  // Acción al agregar el producto al carrito
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('${product.name} agregado al carrito')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}
