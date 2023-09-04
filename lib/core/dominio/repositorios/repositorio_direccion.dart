import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';

abstract class RepositorioDireccion {
  Future<List<Direccion>> getDireccionCuenta({required String cuentaId});

  Future<void> addDireccion({required String cuentaId, required Direccion data});

  Future<void> updateDireccion({required String cuentaId, required Direccion data});

  Future<void> deleteDireccion({required String cuentaId, required String direccionId});

  Future<void> changeDireccionPrimaria({required String cuentaId, required Direccion direccion});
}
