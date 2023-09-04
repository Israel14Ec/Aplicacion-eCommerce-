import 'package:edreams/core/dominio/entidades/lista_deseos/listadeseos.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_lista_deseos.dart';

class GetListaDeseosCuenta {
  final RepositorioListaDeseos _repositorio;

  GetListaDeseosCuenta(this._repositorio);

  Future<List<ListaDeseos>> ejecutar({
    required String cuentaId,
    String busqueda = '',
    String ordenarPor = 'created_at',
    bool descendente = true,
  }) async {
    return _repositorio.getListaDeseosCuenta(
      cuentaId: cuentaId,
      busqueda: busqueda,
      ordenarPor: ordenarPor,
      descendente: descendente,
    );
  }
}
