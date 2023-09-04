import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_transaccion.dart';

class AceptarTransaccion {
  final RepositorioTransaccion _repositorio;

  AceptarTransaccion(this._repositorio);

  Future<void> ejecutar({required Transaccion data}) async {
    return await _repositorio.acceptarTransaccion(data: data);
  }
}
