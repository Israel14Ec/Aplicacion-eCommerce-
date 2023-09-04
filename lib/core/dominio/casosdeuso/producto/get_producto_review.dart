import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_producto.dart';

class GetProductoReview {
  final RepositorioProducto _repositorio;

  GetProductoReview(this._repositorio);

  Future<List<Review>> ejecutar({
    required String productoId,
    String ordenarPor = 'created_at',
    bool descendente = true,
  }) async {
    return await _repositorio.getProductoReview(
      productoId: productoId,
      ordenarPor: ordenarPor,
      descendente: descendente,
    );
  }
}
