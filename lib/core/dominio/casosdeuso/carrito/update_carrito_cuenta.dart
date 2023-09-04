import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/repositorios/repositorio__carrito.dart';

class UpdateCarritoCuenta {
  final RepositorioCarrito _repositorio;

  UpdateCarritoCuenta(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required Carrito data}) async {
    return _repositorio.updateCarritoCuenta(cuentaId: cuentaId, data: data);
  }
}
