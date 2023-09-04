import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_checkout.dart';

class IniciarCheckout {
  final RepositorioCheckout _repositorio;

  IniciarCheckout(this._repositorio);

  Transaccion ejecutar({required List<Carrito> carrito, required Cuenta cuenta}) {
    return _repositorio.iniciarCheckout(carrito: carrito, cuenta: cuenta);
  }
}
