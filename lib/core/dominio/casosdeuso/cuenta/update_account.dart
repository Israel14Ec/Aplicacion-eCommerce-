import '../../repositorios/repositorio_cuenta.dart';

class UpdateCuenta {
  final RepositorioCuenta _repositorio;

  UpdateCuenta(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required Map<String, dynamic> data}) async {
    return _repositorio.updateCuenta(cuentaId: cuentaId, data: data);
  }
}
