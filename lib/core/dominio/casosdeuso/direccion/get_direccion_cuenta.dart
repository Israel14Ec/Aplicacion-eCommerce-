import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_direccion.dart';

class GetDireccionCuenta {
  final RepositorioDireccion _repositorio;

  GetDireccionCuenta(this._repositorio);

  Future<List<Direccion>> ejecutar({required String cuentaId}) async {
    return await _repositorio.getDireccionCuenta(cuentaId: cuentaId);
  }
}
