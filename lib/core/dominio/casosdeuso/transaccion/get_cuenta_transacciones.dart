import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_transaccion.dart';

class GetCuentaTransaccion {
  final RepositorioTransaccion _repositorio;

  GetCuentaTransaccion(this._repositorio);

  Future<List<Transaccion>> ejecutar({
    required String cuentaId,
  }) async {
    return await _repositorio.getCuentaTransaccion(
      cuentaId: cuentaId,
    );
  }
}
