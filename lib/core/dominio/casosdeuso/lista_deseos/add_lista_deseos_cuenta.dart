import 'package:edreams/core/dominio/entidades/lista_deseos/listadeseos.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_lista_deseos.dart';

class AddListaDeseosCuenta {
  final RepositorioListaDeseos _repositorio;

  AddListaDeseosCuenta(this._repositorio);

  Future<void> ejecutar({
    required String cuentaId,
    required ListaDeseos data,
  }) async {
    return _repositorio.addListaDeseosCuenta(cuentaId: cuentaId, listaDeseos: data);
  }
}
