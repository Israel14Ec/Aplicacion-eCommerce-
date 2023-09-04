import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_checkout.dart';

class Pagar {
  final RepositorioCheckout _repositorio;

  Pagar(this._repositorio);

  Future<void> ejecutar({required Transaccion data}) async {
    return await _repositorio.pagar(data: data);
  }
}
