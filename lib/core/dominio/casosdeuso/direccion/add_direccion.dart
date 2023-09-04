import 'package:edreams/core/dominio/repositorios/repositorio_direccion.dart';
import '../../entidades/direccion/direccion.dart';

class AddDireccion {
  final RepositorioDireccion _repositorio;

  AddDireccion(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required Direccion data}) async {
    return await _repositorio.addDireccion(cuentaId: cuentaId, data: data);
  }
}
