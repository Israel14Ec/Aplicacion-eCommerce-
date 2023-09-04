import 'package:edreams/core/dominio/repositorios/repositorio_auten.dart';

class LogoutCuenta {
  final RepositorioAuten _repositorio;

  LogoutCuenta(this._repositorio);

  Future<void> ejecutar() async {
    await _repositorio.logout();
  }
}
