import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_producto.dart';

class AddProducto {
  final RepositorioProducto _repositorio;

  AddProducto(this._repositorio);

  Future<void> ejecutar({required Producto data}) async {
    return _repositorio.addProducto(producto: data);
  }
}
