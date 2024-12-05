import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'producto_model.dart';
import 'carrito_model.dart';
// Pantalla para ver el carrito
import 'dart:ui';

class CatalogoProductos extends StatefulWidget {
  final Carrito carrito;

  const CatalogoProductos({Key? key, required this.carrito}) : super(key: key);

  @override
  _CatalogoProductosState createState() => _CatalogoProductosState();
}

class _CatalogoProductosState extends State<CatalogoProductos> {
  List<Producto> productos = [];
  List<Producto> productosFiltrados = [];
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _obtenerProductos();
  }

  Future<void> _obtenerProductos() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      productos =
          querySnapshot.docs.map((doc) => Producto.fromFirestore(doc)).toList();
      productosFiltrados = List.from(
          productos); // Inicializar productos filtrados con todos los productos
      setState(() {});
    } catch (e) {
      print('Error al obtener productos: $e');
    }
  }

  void _searchProduct(String query) {
    setState(() {
      productosFiltrados = productos
          .where((producto) =>
              producto.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white, // Fondo blanco
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.black), // Ícono negro
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_bag,
                  color: Colors.black), // Ícono negro
              const SizedBox(width: 10),
              Image.asset(
                'assets/logo_negro.png', // Ruta del logo
                height: 40, // Ajusta el tamaño de la imagen
                fit: BoxFit.contain, // Asegura que se ajuste correctamente
              ),
            ],
          ),
          centerTitle: true, // Centra el título (logo e ícono)
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: SizedBox(
                width: 270,
                height: 30,
                child: TextField(
                  controller: _searchController,
                  onChanged: _searchProduct,
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 31, 31, 31)
                            .withOpacity(0.7)),
                    prefixIcon: const Icon(Icons.search,
                        color: Colors.black), // Ícono negro
                    fillColor: const Color.fromARGB(
                        255, 245, 245, 245), // Fondo gris claro
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black), // Texto negro
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart,
                  color: Colors.black), // Ícono negro
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer(); // Abre el drawer
              },
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.black, // Pestaña activa en negro
            indicatorColor: Colors.black, // Indicador negro
            unselectedLabelColor: Colors.grey, // Pestañas inactivas en gris
            tabs: [
              Tab(text: 'Fundas'),
              Tab(text: 'Micas'),
              Tab(text: 'Audífonos'),
              Tab(text: 'Cables'),
            ],
          ),
        ),
        body: Container(
          color: Colors.black, // Fondo negro
          child: productos.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  children: [
                    _buildSeccionProductos(context, 'Fundas'),
                    _buildSeccionProductos(context, 'Micas'),
                    _buildSeccionProductos(context, 'Audífonos'),
                    _buildSeccionProductos(context, 'Cables'),
                  ],
                ),
        ),
        endDrawer: Drawer(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255), // Fondo azul
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mi carrito de compras",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 0, 0, 0), // Texto blanco
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                    color: const Color.fromARGB(255, 0, 0, 0)
                        .withOpacity(0.7)), // Divider blanco
                // Mostrar los productos en el carrito
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
                              color:
                                  Color.fromARGB(255, 0, 0, 0)), // Texto blanco
                        ),
                        subtitle: Text(
                          '\$${producto.precio}',
                          style: const TextStyle(
                              color:
                                  Color.fromARGB(255, 0, 0, 0)), // Texto blanco
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete,
                              color:
                                  Color.fromARGB(255, 0, 0, 0)), // Ícono blanco
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
                      color: Color.fromARGB(255, 0, 0, 0), // Texto blanco
                      fontSize: 20,
                    ),
                  ),
                ),
                // Botón de compra
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0), // Espacio encima del botón
                  child: ElevatedButton(
                    onPressed: () {
                      // Aquí puedes agregar la lógica para realizar la compra
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Compra realizada con éxito!')),
                      );
                      // Redirigir a otra pantalla de pago si es necesario
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green, // Color de fondo verde para el botón
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0), // Alto del botón
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Esquinas cuadradas
                      ),
                      minimumSize:
                          const Size(double.infinity, 50), // Ancho del botón
                    ),
                    child: const Text(
                      'Comprar ahora',
                      style: TextStyle(
                        color: Colors.white, // Texto blanco en el botón
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeccionProductos(BuildContext context, String categoria) {
    final productosFiltradosCategoria =
        productosFiltrados.where((p) => p.categoria == categoria).toList();

    if (productosFiltradosCategoria.isEmpty) {
      return Center(
        child: Text(
          'No hay productos en la categoría $categoria.',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.75,
      ),
      itemCount: productosFiltradosCategoria.length,
      itemBuilder: (context, index) {
        final producto = productosFiltradosCategoria[index];
        return GestureDetector(
          onTap: () {
            // Navegar a la pantalla de detalles del producto
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: ProductoDetalleDialog(producto: producto),
                );
              },
            );
          },
          child: Card(
            color: const Color.fromARGB(255, 44, 44, 44),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      producto.imagenUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        producto.nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Precio: \$${producto.precio.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 76, 228, 84),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 136, 214),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            // Se agrega el producto al carrito
                            widget.carrito.agregarProducto(producto);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    '${producto.nombre} añadido al carrito')),
                          );
                        },
                        child: const Text('Agregar al Carrito'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//-----------------------------------
void mostrarDetalleProducto(BuildContext context, Producto producto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ProductoDetalleDialog(producto: producto);
    },
  );
}

class ProductoDetalleDialog extends StatelessWidget {
  final Producto producto;

  const ProductoDetalleDialog({Key? key, required this.producto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centra las letras
              children: [
                // Imagen del producto
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    producto.imagenUrl,
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 16),
                // Información del producto
                Text(
                  producto.nombre,
                  textAlign: TextAlign.center, // Asegura que el texto se centre
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Categoría: ${producto.categoria}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Marca: ${producto.marca}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Modelo: ${producto.modelo}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Precio: \$${producto.precio.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Descripción: ${producto.descripcion}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Botón circular para cerrar
          Positioned(
            top: 10, // Reduce el espacio superior
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Cierra el diálogo
              },
              child: const CircleAvatar(
                radius: 18, // Ajusta el tamaño para que sea más pequeño
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18, // Ajusta el tamaño del ícono
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Stream<List<Producto>> obtenerProductos() {
  return FirebaseFirestore.instance
      .collection(
          'products') // Asegúrate de que tu colección se llame 'productos'
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => Producto.fromFirestore(doc)).toList();
  });
}

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Lista de Productos'),
        backgroundColor: const Color.fromARGB(255, 0, 136, 214),
      ),
      body: StreamBuilder<List<Producto>>(
        stream:
            obtenerProductos(), // Usamos el Stream para obtener los productos de Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar productos.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay productos disponibles.'));
          }

          final productos = snapshot.data!;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];

              return ListTile(
                leading: Image.asset(producto
                    .imagenUrl), // Asegúrate de que el producto tenga una imagen válida
                title: Text(producto.nombre),
                subtitle: Text('\$${producto.precio.toString()}'),
                onTap: () {
                  // Al hacer clic en un producto, mostramos un diálogo con los detalles del producto
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ProductoDetalleDialog(producto: producto);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: MainScreen(),
    ),
  );
}
