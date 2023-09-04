import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_metodo_pago.dart';

class GetMetodoPago {
  final RepositorioMetodoPago _repositorio;

  GetMetodoPago(this._repositorio);

  Future<List<MetodoPago>> ejecutar({required String cuentaId}) async {
    return await _repositorio.getMetodoPagoCuenta(cuentaId: cuentaId);
  }
}
