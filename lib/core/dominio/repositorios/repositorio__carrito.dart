import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';

abstract class RepositorioCarrito {
  Future<List<Carrito>> getCarritoCuenta({required String cuentaId});

  Future<void> addCarritoCuenta({required String cuentaId, required Carrito data});

  Future<void> updateCarritoCuenta({required String cuentaId, required Carrito data});

  Future<void> deleteCarritoCuenta({required String cuentaId, required String carritoId});
}
