import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  String? _selectedCategory;
  String? _selectedStatus = 'Disponible'; // Default value
  String? _selectedBrand;
  String? _selectedColor;
  bool _isLoading = false;

  final List<String> _categories = ['Fundas', 'Cables', 'Micas', 'Audífonos'];
  final List<String> _statusOptions = ['Disponible', 'No Disponible'];
  final List<String> _brands = ['Apple', 'Samsung', 'Xiaomi', 'Huawei']; // Opciones para Marca
  final List<String> _colors = ['Rojo', 'Azul', 'Negro', 'Blanco']; // Opciones para Color

  // Método para guardar el producto en Firestore
  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseFirestore.instance.collection('products').add({
          'name': _nameController.text,
          'price': double.parse(_priceController.text),
          'description': _descriptionController.text,
          'category': _selectedCategory,
          'model': _modelController.text,
          'image_url': _imageUrlController.text, // Guarda la URL de la imagen
          'brand': _selectedBrand, // Guarda la marca seleccionada
          'color': _selectedColor, // Guarda el color seleccionado
          'status': _selectedStatus, // Guarda el estado (Disponible o No Disponible)
          'created_at': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto agregado exitosamente')),
        );

        // Limpiar campos
        _nameController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _modelController.clear();
        _imageUrlController.clear();
        setState(() {
          _selectedCategory = null;
          _selectedStatus = 'Disponible';
          _selectedBrand = null;
          _selectedColor = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre del Producto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un precio';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor ingresa un número válido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una descripción';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Categoría'),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona una categoría';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un modelo';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: 'Enlace de Imagen'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un enlace de imagen';
                    }
                    //if (!Uri.parse(value).isAbsolute) {
                     // return 'Por favor ingresa un enlace válido';
                    //}
                    return null;
                  },
                ),
              ),
              // Dropdown para Marca
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedBrand,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  items: _brands.map((brand) {
                    return DropdownMenuItem(
                      value: brand,
                      child: Text(brand),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBrand = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona una marca';
                    }
                    return null;
                  },
                ),
              ),
              // Dropdown para Color
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedColor,
                  decoration: const InputDecoration(labelText: 'Color'),
                  items: _colors.map((color) {
                    return DropdownMenuItem(
                      value: color,
                      child: Text(color),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedColor = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un color';
                    }
                    return null;
                  },
                ),
              ),
              // Dropdown para Estado
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(labelText: 'Estado'),
                  items: _statusOptions.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un estado';
                    }
                    return null;
                  },
                ),
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _saveProduct,
                      child: const Text('Guardar Producto'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

