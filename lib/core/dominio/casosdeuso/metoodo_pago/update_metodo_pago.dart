import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_metodo_pago.dart';

class UpdateMetodoPago {
  final RepositorioMetodoPago _repositorio;

  UpdateMetodoPago(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required MetodoPago data}) async {
    return await _repositorio.updateMetodoPago(cuentaId: cuentaId, data: data);
  }
}
