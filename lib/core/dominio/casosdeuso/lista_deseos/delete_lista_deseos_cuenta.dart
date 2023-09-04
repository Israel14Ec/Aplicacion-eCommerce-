import 'package:edreams/core/dominio/repositorios/repositorio_lista_deseos.dart';

class DeleteListaDeseosCuenta {
  final RepositorioListaDeseos _repositorio;

  DeleteListaDeseosCuenta(this._repositorio);

  Future<void> ejecutar({
    required String cuentaId,
    required String listadeseosId,
  }) async {
    return _repositorio.deleteListaDeseosCuenta(
      cuentaId: cuentaId,
      listadeseosId: listadeseosId,
    );
  }
}
