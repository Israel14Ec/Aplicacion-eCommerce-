import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_transaccion.dart';

class GetTodasTransacciones {
  final RepositorioTransaccion _repositorio;

  GetTodasTransacciones(this._repositorio);

  Future<List<Transaccion>> ejecutar() async {
    return await _repositorio.getTodasTransacciones();
  }
}
