import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';

abstract class RepositorioMetodoPago {
  Future<List<MetodoPago>> getMetodoPagoCuenta({required String cuentaId});

  Future<void> addMetodoPago({required String cuentaId, required MetodoPago data});

  Future<void> updateMetodoPago({required String cuentaId, required MetodoPago data});

  Future<void> deleteMetodoPago({required String cuentaId, required String metodoPagoId});

  Future<void> changeMetodoPagoPrimario({required String cuentaId, required MetodoPago metodoPago});
}
