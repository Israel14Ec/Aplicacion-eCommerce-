import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_producto.dart';

class UpdateProducto {
  final RepositorioProducto _repositorio;

  UpdateProducto(this._repositorio);

  Future<void> ejecutar({required Producto data}) async {
    return _repositorio.updateProducto(producto: data);
  }
}
