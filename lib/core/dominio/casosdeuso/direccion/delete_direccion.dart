import 'package:edreams/core/dominio/repositorios/repositorio_direccion.dart';

class DeleteDireccion {
  final RepositorioDireccion _repositorio;

  DeleteDireccion(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required String direccionId}) async {
    return await _repositorio.deleteDireccion(cuentaId: cuentaId, direccionId: direccionId);
  }
}
