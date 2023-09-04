import 'package:edreams/core/dominio/repositorios/repositorio_metodo_pago.dart';

class DeleteMetodoPago {
  final RepositorioMetodoPago _repositorio;

  DeleteMetodoPago(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required String metodopagoId}) async {
    return await _repositorio.deleteMetodoPago(cuentaId: cuentaId, metodoPagoId: metodopagoId);
  }
}
