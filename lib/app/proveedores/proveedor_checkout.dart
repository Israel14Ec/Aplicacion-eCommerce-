import 'package:edreams/core/dominio/casosdeuso/carrito/delete_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/checkout/iniciar_checkout.dart';
import 'package:edreams/core/dominio/casosdeuso/checkout/pagar.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/update_producto.dart';
import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProveedorCheckout with ChangeNotifier {
  final IniciarCheckout iniciarCheckout;
  final Pagar pagar;
  final UpdateProducto updateProducto;
  final DeleteCuentaCarrito deleteCuentaCarrito;

  ProveedorCheckout({
    required this.iniciarCheckout,
    required this.pagar,
    required this.updateProducto,
    required this.deleteCuentaCarrito,
  });

  // Estado de carga
  bool _isCargando = false;
  bool get isCargando => _isCargando;

  late Transaccion _dataTransaccion;
  Transaccion get dataTransaction => _dataTransaccion;
  set setTransaction(Transaccion data) => _dataTransaccion = data;

  int _contadorObjetos = 0;
  int get contadorObjetos => _contadorObjetos;

  iniciar({required List<Carrito> carrito, required Cuenta cuenta}) {
    _contadorObjetos = 0;
    _dataTransaccion = iniciarCheckout.ejecutar(carrito: carrito, cuenta: cuenta);
    for (var elemento in carrito) {
      _contadorObjetos += elemento.cantidad;
    }
  }

  Future<void> checkoutPagar() async {
    try {
      _isCargando = true;
      notifyListeners();

      // Insertar data para la transaccion
      _dataTransaccion.createdAt = DateTime.now();
      _dataTransaccion.updatedAt = DateTime.now();
      await pagar.ejecutar(data: _dataTransaccion);

      String cuentaId = FirebaseAuth.instance.currentUser!.uid;

      // Sustraer stock del producto y remover el carrito
      await Future.forEach(_dataTransaccion.productoComprado, (Carrito elemento) async {
        Producto temp = elemento.producto!;

        temp.stock -= elemento.cantidad;
        if (temp.stock < 0) temp.stock = 0;

        await updateProducto.ejecutar(data: temp);
        await deleteCuentaCarrito.ejecutar(cuentaId: cuentaId, carritoId: elemento.carritoId);
      });

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al realizar el pago: ${e.toString()}');
      notifyListeners();
    }
  }

  updateCuentaTotal({required Direccion? direccion}) {
    if (direccion != null) {
      dataTransaction.totalCuenta = dataTransaction.costeEnvio! + dataTransaction.precioTotal!;
    } else {
      dataTransaction.totalCuenta = null;
    }
  }
}
