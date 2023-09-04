import 'package:edreams/core/dominio/repositorios/repositorio_producto.dart';

class DeleteProducto {
  final RepositorioProducto _repositorio;

  DeleteProducto(this._repositorio);

  Future<void> ejecutar({required String productoId}) async {
    return await _repositorio.deleteProducto(productoId: productoId);
  }
}
