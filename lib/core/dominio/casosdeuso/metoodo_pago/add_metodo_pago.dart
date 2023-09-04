import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_metodo_pago.dart';

class AddMetodoPago {
  final RepositorioMetodoPago _repositorio;

  AddMetodoPago(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required MetodoPago data}) async {
    return await _repositorio.addMetodoPago(cuentaId: cuentaId, data: data);
  }
}
