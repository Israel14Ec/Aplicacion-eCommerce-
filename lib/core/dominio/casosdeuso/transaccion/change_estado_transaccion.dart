import 'package:edreams/core/dominio/repositorios/repositorio_transaccion.dart';

class ChangeEstadoTransaccion {
  final RepositorioTransaccion _repositorio;

  ChangeEstadoTransaccion(this._repositorio);

  Future<void> ejecutar({required String transaccionID, required int estado}) async {
    return await _repositorio.changeEstadoTransaccion(transaccionId: transaccionID, estado: estado);
  }
}
