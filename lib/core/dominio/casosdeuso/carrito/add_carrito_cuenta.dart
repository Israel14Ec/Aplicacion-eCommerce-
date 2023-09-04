import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/repositorios/repositorio__carrito.dart';

class AddCarritoCuenta {
  final RepositorioCarrito _repositorio;

  AddCarritoCuenta(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required Carrito data}) async {
    return _repositorio.addCarritoCuenta(cuentaId: cuentaId, data: data);
  }
}
