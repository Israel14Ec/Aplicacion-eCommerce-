import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';

abstract class RepositorioCuenta {
  Future<Cuenta?> getPerfilCuenta({required String cuentaId});

  Future<List<Cuenta>> getTodasCuentas();

  Future<void> banCuenta({required String cuentaId, required bool ban});

  Future<void> updateCuenta({required String cuentaId, required Map<String, dynamic> data});
}
