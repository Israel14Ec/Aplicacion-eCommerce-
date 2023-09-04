import 'package:edreams/core/dominio/casosdeuso/carrito/add_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/carrito/delete_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/carrito/get_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/carrito/update_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/get_producto.dart';
import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProveedorCarrito with ChangeNotifier {
  final AddCarritoCuenta addCarritoCuenta;
  final GetCarritoCuenta getCarritoCuenta;
  final UpdateCarritoCuenta updateCarritoCuenta;
  final DeleteCuentaCarrito deleteCuentaCarrito;
  final GetProducto getProducto;

  ProveedorCarrito({
    required this.addCarritoCuenta,
    required this.getCarritoCuenta,
    required this.updateCarritoCuenta,
    required this.deleteCuentaCarrito,
    required this.getProducto,
  });

  // Estado de carga
  bool _isCargando = false;
  bool get isCargando => _isCargando;
  bool _primeraCarga = true;
  bool get primeraCarga => _primeraCarga;

  // Lista del carrito
  List<Carrito> _listaCarrito = [];
  List<Carrito> get listaCarrito => _listaCarrito;

  // Contador para el carrito
  int contadorCarrito = 0;
  double total = 0;

  Future<void> addCarrito({
    required String cuentaId,
    required Carrito data,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();

      await addCarritoCuenta.ejecutar(cuentaId: cuentaId, data: data);

      listaCarrito.add(data);

      contadorCarritos();

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error al añadir al carrito: ${e.toString()}');
      _isCargando = false;
      notifyListeners();
    }
  }

  getCarrito({required String cuentaId}) async {
    _primeraCarga = true;
    notifyListeners();

    try {
      var respuesta = await getCarritoCuenta.ejecutar(cuentaId: cuentaId);
      contadorCarrito = 0;
      _listaCarrito.clear();

      if (respuesta.isNotEmpty) {
        _listaCarrito = respuesta;
        await Future.forEach<Carrito>(_listaCarrito, (element) async {
          var dataProducto = await getProducto.ejecutar(productoId: element.productoId);
          element.producto = dataProducto;
        });
        contadorCarritos();
      }

      _primeraCarga = false;
      notifyListeners();
    } catch (e) {
      _primeraCarga = false;
      debugPrint('Error al obtener el carrito: ${e.toString()}');
      notifyListeners();
    }
  }

  updateCarrito({
    required Carrito data,
  }) {
    try {
      _isCargando = true;
      notifyListeners();

      String cuentaId = FirebaseAuth.instance.currentUser!.uid;

      int carritoIndice = listaCarrito.indexWhere((element) => element.carritoId == data.carritoId);

      if (listaCarrito[carritoIndice].cantidad == 0) {
        deleteCarrito(cuentaId: cuentaId, carritoId: listaCarrito[carritoIndice].carritoId);
        listaCarrito.removeAt(carritoIndice);
      } else {
        listaCarrito[carritoIndice] = data;
        updateCarritoCuenta.ejecutar(cuentaId: cuentaId, data: data);
      }

      contadorCarritos();

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error al actualizar el carrito: ${e.toString()}');
      _isCargando = false;
      notifyListeners();
    }
  }

  deleteCarrito({
    required String cuentaId,
    required String carritoId,
  }) {
    try {
      deleteCuentaCarrito.ejecutar(cuentaId: cuentaId, carritoId: carritoId);
    } catch (e) {
      debugPrint('Error al eliminar el carrito: ${e.toString()}');
    }
  }

  contadorCarritos() {
    contadorCarrito = 0;
    total = 0;
    for (var elemento in listaCarrito) {
      contadorCarrito += elemento.cantidad;
      total += elemento.cantidad * elemento.producto!.productoPrecio;
    }
  }
}
