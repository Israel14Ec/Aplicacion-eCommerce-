import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_metodo_pago.dart';

class ChangeMetodoPagoPrimario {
  final RepositorioMetodoPago _repositorio;

  ChangeMetodoPagoPrimario(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required MetodoPago metodoPago}) async {
    return await _repositorio.changeMetodoPagoPrimario(cuentaId: cuentaId, metodoPago: metodoPago);
  }
}
