import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';

import '../entidades/carrito/carrito.dart';
import '../entidades/cuenta/cuenta.dart';

abstract class RepositorioCheckout {
  Transaccion iniciarCheckout({
    required List<Carrito> carrito,
    required Cuenta cuenta,
  });

  Future<void> pagar({
    required Transaccion data,
  });
}
