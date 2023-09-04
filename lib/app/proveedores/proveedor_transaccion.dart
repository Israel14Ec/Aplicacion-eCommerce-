import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/get_perfil_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/aceptar_transaccion.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/add_review.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/change_estado_transaccion.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/get_cuenta_transacciones.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/get_todas_transacciones.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/get_transaccion.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProveedorTransaccion with ChangeNotifier {
  final GetCuentaTransaccion getCuentaTransaccion;
  final GetTransaccion getTransaccion;
  final GetTodasTransacciones getTodasTransacciones;
  final AceptarTransaccion acceptTransaccion;
  final AddReview addReview;
  final ChangeEstadoTransaccion changeEstadoTransaccion;
  final GetPerfilCuenta getPerfilCuenta;

  ProveedorTransaccion({
    required this.getCuentaTransaccion,
    required this.getTransaccion,
    required this.getTodasTransacciones,
    required this.acceptTransaccion,
    required this.addReview,
    required this.changeEstadoTransaccion,
    required this.getPerfilCuenta,
  });

  // Estado de carga
  bool _isCargando = true;
  bool get isCargando => _isCargando;
  bool _isCargandoDetalle = true;
  bool get isCargandoDetalle => _isCargandoDetalle;

  // Lista de transacciones
  List<Transaccion> _listaTransaccion = [];
  List<Transaccion> get listaTransaccion => _listaTransaccion;

  // Detalle de la transaccion
  Transaccion? _detalleTransaccion;
  Transaccion? get detalleTransaccion => _detalleTransaccion;

  // Contador de objetos
  int _contadorObjetos = 0;
  int get contadorObjetos => _contadorObjetos;

  cargarTransaccionCuenta({
    String busqueda = '',
    OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();
      _listaTransaccion.clear();

      String cuentaId = FirebaseAuth.instance.currentUser!.uid;

      var respuesta = await getCuentaTransaccion.ejecutar(cuentaId: cuentaId);

      if (respuesta.isNotEmpty) {
        _listaTransaccion = respuesta;
        ordenarLista(ordenarPorEnum);
        if (busqueda.isNotEmpty) {
          _listaTransaccion = _listaTransaccion
              .where(
                (elemento) => elemento.productoComprado.any(
                  (carrito) => carrito.producto!.productoNombre.toLowerCase().contains(busqueda.toLowerCase()),
                ),
              )
              .toList();
        }
      }

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al cargar la transaccion de la cuenta: ${e.toString()}');
      notifyListeners();
    }
  }

  cargarDetallesTransaccion({required String transaccionId}) async {
    try {
      _isCargandoDetalle = true;
      notifyListeners();

      var respuesta = await getTransaccion.ejecutar(transaccionId: transaccionId);

      if (respuesta != null) {
        _detalleTransaccion = respuesta;
        _contadorObjetos = 0;

        if (FlavorConfig.isAdmin()) {
          if (_detalleTransaccion!.cuenta == null) {
            var data = await getPerfilCuenta.ejecutar(cuentaId: _detalleTransaccion!.cuentaId);
            _detalleTransaccion!.cuenta = data;
          }
        }

        for (var elemento in _detalleTransaccion!.productoComprado) {
          _contadorObjetos += elemento.cantidad;
        }
      }

      _isCargandoDetalle = false;
      notifyListeners();
    } catch (e) {
      _isCargandoDetalle = false;
      debugPrint('Error al cargar los detalles de la transaccion: ${e.toString()}');
      notifyListeners();
    }
  }

  cargarTodasTransaccion({
    String busqueda = '',
    OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();

      var respuesta = await getTodasTransacciones.ejecutar();

      if (respuesta.isNotEmpty) {
        _listaTransaccion = respuesta;

        await Future.forEach<Transaccion>(_listaTransaccion, (element) async {
          if (element.cuenta == null) {
            var data = await getPerfilCuenta.ejecutar(cuentaId: element.cuentaId);
            element.cuenta = data;
          }
        });

        ordenarLista(ordenarPorEnum);
        if (busqueda.isNotEmpty) {
          _listaTransaccion = _listaTransaccion
              .where(
                (elemento) => elemento.productoComprado.any(
                  (carrito) => carrito.producto!.productoNombre.toLowerCase().contains(busqueda.toLowerCase()),
                ),
              )
              .toList();
        }
      }

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al cargar la transaccion de la cuenta: ${e.toString()}');
      notifyListeners();
    }
  }

  aceptar() async {
    try {
      _isCargando = true;
      notifyListeners();

      await acceptTransaccion.ejecutar(data: _detalleTransaccion!);
      await cargarDetallesTransaccion(transaccionId: _detalleTransaccion!.transaccionId);
      cargarTransaccionCuenta();

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al aceptar la transaccion: ${e.toString()}');
      notifyListeners();
    }
  }

  Future<void> subirReview({required String transaccionId, required List<Review> data}) async {
    try {
      _isCargando = true;
      notifyListeners();

      await Future.forEach(data, (Review review) async {
        await addReview.ejecutar(
          transaccionId: transaccionId,
          data: review,
        );
      });

      await cambiarEstado(transaccionId: transaccionId, estado: EstadoTransaccion.calificado.valor);
      await cargarDetallesTransaccion(transaccionId: transaccionId);

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al subir review: ${e.toString()}');
      notifyListeners();
    }
  }

  cambiarEstado({required String transaccionId, required int estado}) async {
    try {
      _isCargandoDetalle = true;
      notifyListeners();

      await changeEstadoTransaccion.ejecutar(transaccionID: transaccionId, estado: estado);
      await cargarDetallesTransaccion(transaccionId: transaccionId);
      cargarTodasTransaccion();
    } catch (e) {
      _isCargandoDetalle = false;
      debugPrint('Error al cambiar el estado de la transaccion: ${e.toString()}');
      notifyListeners();
    }
  }

  ordenarLista(OrdenarPorEnum data) {
    switch (data) {
      case OrdenarPorEnum.nuevo:
        listaTransaccion.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        break;
      case OrdenarPorEnum.viejo:
        listaTransaccion.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        break;
      case OrdenarPorEnum.barato:
        listaTransaccion.sort((a, b) => a.totalPagar!.compareTo(b.totalPagar!));
        break;
      case OrdenarPorEnum.caro:
        listaTransaccion.sort((a, b) => b.totalPagar!.compareTo(a.totalPagar!));
        break;
      default:
        listaTransaccion.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        break;
    }
  }
}
