import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_components/services/auth_service.dart';

class ProductCRUDScreen extends StatefulWidget {
  const ProductCRUDScreen({Key? key}) : super(key: key);

  @override
  _ProductCRUDScreenState createState() => _ProductCRUDScreenState();
}

class _ProductCRUDScreenState extends State<ProductCRUDScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();  // Buscador

  String? _selectedCategory;
  String? _selectedProductId;
  String? _filterCategory; // Filtro de categoría
  String? _selectedBrand; // Marca
  String? _selectedColor; // Color
  String? _selectedStatus; // Estado (Disponible o No)

  bool _isLoading = false;

  final List<String> _categories = ['Fundas', 'Cables', 'Micas', 'Audífonos'];
  final List<String> _brands = ['Apple', 'Samsung', 'Xiaomi', 'Huawei']; // Lista de marcas
  final List<String> _colors = ['Rojo', 'Azul', 'Negro', 'Blanco']; // Lista de colores
  final List<String> _states = ['Disponible', 'No Disponible']; // Lista de estados

  // Guardar producto (crear o actualizar)
  Future<void> _saveProduct() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _modelController.text.isEmpty ||
        _selectedCategory == null ||
        _selectedBrand == null ||
        _selectedColor == null ||
        _selectedStatus == null ||
        _imageUrlController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Completa todos los campos')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final data = {
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'description': _descriptionController.text,
        'model': _modelController.text,
        'category': _selectedCategory,
        'brand': _selectedBrand,
        'color': _selectedColor,
        'status': _selectedStatus,
        'image_url': _imageUrlController.text,
        'created_at': FieldValue.serverTimestamp(),
      };

      if (_selectedProductId == null) {
        await _firestore.collection('products').add(data);
      } else {
        await _firestore
            .collection('products')
            .doc(_selectedProductId)
            .update(data);
      }

      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto guardado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Confirmar y eliminar producto
  Future<void> _confirmDeleteProduct(String productId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar este producto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(productId);
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto eliminado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar el producto: $e')),
      );
    }
  }

  // Limpiar formulario
  void _clearForm() {
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _modelController.clear();
    _imageUrlController.clear();
    _searchController.clear();
    setState(() {
      _selectedCategory = null;
      _selectedProductId = null;
      _selectedBrand = null;
      _selectedColor = null;
      _selectedStatus = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text('Administrador', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () async {
              await AuthService().signout(context: context);
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView( 
       // Hacer que la pantalla sea desplazable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Buscador
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar producto',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {}); // Actualizar la lista de productos al buscar
                },
              ),
            ),
            // Dropdown para filtrar productos por categoría
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: DropdownButton<String>(
                value: _filterCategory,
                hint: const Text('Filtrar por Categoría',style: TextStyle(color: Colors.white),),
                isExpanded: true,
                items: [null, ..._categories]
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category ?? 'Todas las Categorías', style: const TextStyle(color: Colors.white),),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _filterCategory = value;
                  });
                },
              ),
            ),
            // Mostrar lista de productos
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar los productos'));
                }

                var products = snapshot.data!.docs;

                // Filtrar productos por nombre de búsqueda
                if (_searchController.text.isNotEmpty) {
                  products = products.where((doc) {
                    final product = doc.data() as Map<String, dynamic>;
                    return product['name']
                        .toString()
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase());
                  }).toList();
                }

                // Filtrar productos por categoría seleccionada
                if (_filterCategory != null) {
                  products = products.where((doc) {
                    final product = doc.data() as Map<String, dynamic>;
                    return product['category'] == _filterCategory;
                  }).toList();
                }

                return ListView.builder(
                  shrinkWrap: true,  // Asegurarse de que la lista no ocupe más espacio del necesario
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index].data() as Map<String, dynamic>;
                    final productId = products[index].id;

                    return ListTile(
                      leading: product['image_url'] != null
                          ? Image.network(product['image_url'], width: 50, fit: BoxFit.cover)
                          : const Icon(Icons.image),
                      title: Text(product['name'], style: const TextStyle(color: Colors.white)),
                      subtitle: Text('Precio: \$${product['price']},', style: const TextStyle(color: Colors.white),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              setState(() {
                                _nameController.text = product['name'];
                                _priceController.text = product['price'].toString();
                                _descriptionController.text = product['description'];
                                _modelController.text = product['model'];
                                _selectedCategory = product['category'];
                                _selectedBrand = product['brand'];
                                _selectedColor = product['color'];
                                _selectedStatus = product['status'];
                                _imageUrlController.text = product['image_url'];
                                _selectedProductId = productId;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDeleteProduct(productId),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const Divider(),
            _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Nombre del Producto'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _priceController,
                          decoration: const InputDecoration(labelText: 'Precio'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _descriptionController,
                          decoration: const InputDecoration(labelText: 'Descripción'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _modelController,
                          decoration: const InputDecoration(labelText: 'Modelo'),
                        ),
                      ),
                      Padding(
                        
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _imageUrlController,
                          decoration: const InputDecoration(labelText: 'Enlace de Imagen'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: const InputDecoration(labelText: 'Categoría', ),
                          items: _categories
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedBrand,
                          decoration: const InputDecoration(labelText: 'Marca'),
                          items: _brands
                              .map((brand) => DropdownMenuItem(
                                    value: brand,
                                    child: Text(brand),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedBrand = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedColor,
                          decoration: const InputDecoration(labelText: 'Color'),
                          items: _colors
                              .map((color) => DropdownMenuItem(
                                    value: color,
                                    child: Text(color),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedColor = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: const InputDecoration(labelText: 'Estado'),
                          items: _states
                              .map((state) => DropdownMenuItem(
                                    value: state,
                                    child: Text(state),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value;
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _saveProduct,
                        child: Text(_selectedProductId == null
                            ? 'Crear Producto'
                            : 'Actualizar Producto',style: const TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

