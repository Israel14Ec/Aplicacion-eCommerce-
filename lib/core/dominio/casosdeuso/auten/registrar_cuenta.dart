import 'package:edreams/core/dominio/repositorios/repositorio_auten.dart';

class RegistrarCuenta {
  final RepositorioAuten _repositorio;

  RegistrarCuenta(this._repositorio);

  Future<void> ejecutar({
    required String email,
    required String password,
    required String nombre,
    required String numeroTelefonico,
    required int rol,
  }) async {
    await _repositorio.registro(
      email: email,
      password: password,
      nombre: nombre,
      numeroTelefonico: numeroTelefonico,
      rol: rol,
    );
  }
}
