import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/repositorios/repositorio__carrito.dart';

class GetCarritoCuenta {
  final RepositorioCarrito _repositorio;

  GetCarritoCuenta(this._repositorio);

  Future<List<Carrito>> ejecutar({required String cuentaId}) async {
    return _repositorio.getCarritoCuenta(cuentaId: cuentaId);
  }
}
