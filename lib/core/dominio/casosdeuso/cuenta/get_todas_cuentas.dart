import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_cuenta.dart';

class GetTodasCuentas {
  final RepositorioCuenta _repositorio;

  GetTodasCuentas(this._repositorio);

  Future<List<Cuenta>> ejecutar() async {
    return _repositorio.getTodasCuentas();
  }
}
