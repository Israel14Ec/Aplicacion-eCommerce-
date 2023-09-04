import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_cuenta.dart';

class GetPerfilCuenta {
  final RepositorioCuenta _repositorio;

  GetPerfilCuenta(this._repositorio);

  Future<Cuenta?> ejecutar({required String cuentaId}) async {
    return _repositorio.getPerfilCuenta(cuentaId: cuentaId);
  }
}
