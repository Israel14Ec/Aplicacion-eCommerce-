import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_producto.dart';

class GetProducto {
  final RepositorioProducto _repositorio;

  GetProducto(this._repositorio);

  Future<Producto?> ejecutar({required String productoId}) async {
    return await _repositorio.getProducto(productoId: productoId);
  }
}
