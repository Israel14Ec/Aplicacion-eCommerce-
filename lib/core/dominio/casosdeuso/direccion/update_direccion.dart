import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_direccion.dart';

class UpdateDireccion {
  final RepositorioDireccion _repositorio;

  UpdateDireccion(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required Direccion data}) async {
    return await _repositorio.updateDireccion(cuentaId: cuentaId, data: data);
  }
}
