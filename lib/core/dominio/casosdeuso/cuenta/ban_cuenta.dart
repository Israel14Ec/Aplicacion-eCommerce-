import 'package:edreams/core/dominio/repositorios/repositorio_cuenta.dart';

class BanCuenta {
  final RepositorioCuenta _repositorio;

  BanCuenta(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required bool ban}) async {
    return _repositorio.banCuenta(cuentaId: cuentaId, ban: ban);
  }
}
