import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_transaccion.dart';

class GetTransaccion {
  final RepositorioTransaccion _repositorio;

  GetTransaccion(this._repositorio);

  Future<Transaccion?> ejecutar({required String transaccionId}) async {
    return await _repositorio.getTransaccion(
      transaccionId: transaccionId,
    );
  }
}
