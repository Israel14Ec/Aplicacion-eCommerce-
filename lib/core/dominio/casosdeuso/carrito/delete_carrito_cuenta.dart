import 'package:edreams/core/dominio/repositorios/repositorio__carrito.dart';

class DeleteCuentaCarrito {
  final RepositorioCarrito _repositorio;

  DeleteCuentaCarrito(this._repositorio);

  Future<void> ejecutar({required String cuentaId, required String carritoId}) async {
    return _repositorio.deleteCarritoCuenta(cuentaId: cuentaId, carritoId: carritoId);
  }
}
