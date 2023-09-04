abstract class RepositorioAuten {
  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> registro({
    required String email,
    required String password,
    required String nombre,
    required String numeroTelefonico,
    required int rol,
  });

  Future<void> logout();
}
