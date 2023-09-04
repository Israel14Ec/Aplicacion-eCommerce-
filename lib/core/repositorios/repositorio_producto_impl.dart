import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/app/constantes/coleccion_nombre.dart';
import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_producto.dart';

class RepositorioProductoImpl implements RepositorioProducto {
  final CollectionReference collectionReference;
  RepositorioProductoImpl({required this.collectionReference});

  @override
  Future<void> addProducto({required Producto producto}) async {
    await collectionReference.doc(producto.productoId).set(producto.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteProducto({required String productoId}) async {
    await collectionReference.doc(productoId).update({
      'is_deleted': true,
      'stock': 0,
    });
  }

  @override
  Future<List<Producto>> getListaProducto({
    String busqueda = '',
    String ordenarPor = 'created_at',
    bool descendente = true,
  }) async {
    Query query = collectionReference.where('is_deleted', isEqualTo: false);
    List<Producto> temp = [];

    var data = await query.get();

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => Producto.fromJson(e.data() as Map<String, dynamic>)));
    }

    if (busqueda.isNotEmpty) {
      temp = temp.where((element) => element.productoNombre.toLowerCase().contains(busqueda.toLowerCase())).toList();
    }

    return temp;
  }

  @override
  Future<Producto?> getProducto({required String productoId}) async {
    var data = await collectionReference.doc(productoId).get();

    if (data.exists) {
      return Producto.fromJson(data.data() as Map<String, dynamic>);
    }

    return null;
  }

  @override
  Future<List<Review>> getProductoReview({
    required String productoId,
    String ordenarPor = 'created_at',
    bool descendente = true,
  }) async {
    Query query =
        collectionReference.doc(productoId).collection(ColeccionNombre.kREVIEW).orderBy(ordenarPor, descending: descendente);
    List<Review> temp = [];

    var data = await query.get();

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => Review.fromJson(e.data() as Map<String, dynamic>)));
    }

    return temp;
  }

  @override
  Future<void> updateProducto({required Producto producto}) async {
    await collectionReference.doc(producto.productoId).update(producto.toJson());
  }
}
