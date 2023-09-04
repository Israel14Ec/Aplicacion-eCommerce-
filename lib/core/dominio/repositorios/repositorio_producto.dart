import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';

abstract class RepositorioProducto {
  Future<List<Producto>> getListaProducto({
    String busqueda = '',
    String ordenarPor = 'created_at',
    bool descendente = true,
  });

  Future<Producto?> getProducto({required String productoId});

  Future<List<Review>> getProductoReview({
    required String productoId,
    String ordenarPor = 'created_at',
    bool descendente = true,
  });

  Future<void> addProducto({required Producto producto});

  Future<void> updateProducto({required Producto producto});

  Future<void> deleteProducto({required String productoId});
}
