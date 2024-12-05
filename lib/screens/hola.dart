import 'package:cloud_firestore/cloud_firestore.dart';
import 'producto_model.dart';

class ProductoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtener productos con filtración (por ejemplo, por categoría)
  Future<List<Producto>> obtenerProductosPorCategoria(String categoria) async {
    QuerySnapshot snapshot = await _db
        .collection('productos')
        .where('category', isEqualTo: categoria) // Filtrar por categoría
        .get();

    return snapshot.docs
        .map((doc) => Producto.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
  }
}