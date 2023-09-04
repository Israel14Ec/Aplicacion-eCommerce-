import '../../repositorios/repositorio_auten.dart';

class LoginCuenta {
  final RepositorioAuten _repositorio;

  LoginCuenta(this._repositorio);

  Future<void> ejecutar({required String email, required String password}) async {
    await _repositorio.login(email: email, password: password);
  }
}
