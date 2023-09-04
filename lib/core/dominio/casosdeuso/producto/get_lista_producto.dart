import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_producto.dart';

class GetListaProducto {
  final RepositorioProducto _repositorio;

  GetListaProducto(this._repositorio);

  Future<List<Producto>> ejecutar({
    String busqueda = '',
    String ordenarPor = 'created_at',
    bool descendente = true,
  }) async {
    return _repositorio.getListaProducto(
      busqueda: busqueda,
      ordenarPor: ordenarPor,
      descendente: descendente,
    );
  }
}
