import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_direccion.dart';

class ChangeDireccionPrimaria {
  final RepositorioDireccion _repositorio;

  ChangeDireccionPrimaria(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required Direccion data}) async {
    return await _repositorio.changeDireccionPrimaria(cuentaId: cuentaId, direccion: data);
  }
}
