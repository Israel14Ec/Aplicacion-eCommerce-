import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/add_metodo_pago.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/change_metodo_pago_primario.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/delete_metodo_pago.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/get_metodo_pago_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/update_metodo_pago.dart';
import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:flutter/material.dart';

class ProveedorMetodoPago with ChangeNotifier {
  final AddMetodoPago addMetodoPago;
  final GetMetodoPago getMetodoPago;
  final UpdateMetodoPago updateMetodoPago;
  final DeleteMetodoPago deleteMetodoPago;
  final ChangeMetodoPagoPrimario changeMetodoPagoPrimario;

  ProveedorMetodoPago({
    required this.addMetodoPago,
    required this.getMetodoPago,
    required this.updateMetodoPago,
    required this.deleteMetodoPago,
    required this.changeMetodoPagoPrimario,
  });

  // Estado de carga
  bool _isCargando = false;
  bool get isCargando => _isCargando;

  // Listar metodos de pago
  List<MetodoPago> _listaMetodoPago = [];
  List<MetodoPago> get listaMetodoPago => _listaMetodoPago;

  Future<void> add({
    required String cuentaId,
    required MetodoPago data,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();

      await addMetodoPago.ejecutar(cuentaId: cuentaId, data: data);
      _listaMetodoPago.add(data);

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al añadir el metodo de pago: ${e.toString()}');
      notifyListeners();
    }
  }

  getMetodoPagoCuenta({required String cuentaId}) async {
    try {
      _isCargando = true;
      notifyListeners();
      _listaMetodoPago.clear();

      var respuesta = await getMetodoPago.ejecutar(cuentaId: cuentaId);

      if (respuesta.isNotEmpty) {
        _listaMetodoPago = respuesta;
      }

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al obtener el metodo de pago: ${e.toString()}');
      notifyListeners();
    }
  }

  Future<void> update({
    required String cuentaId,
    required MetodoPago data,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();

      await updateMetodoPago.ejecutar(cuentaId: cuentaId, data: data);
      int indice = listaMetodoPago.indexWhere((elemento) => elemento.metodoPagoId == data.metodoPagoId);
      listaMetodoPago[indice] = data;

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al actualizar el metodo de pago: ${e.toString()}');
      notifyListeners();
    }
  }

  delete({
    required String cuentaId,
    required String metodoPagoId,
  }) async {
    try {
      await deleteMetodoPago.ejecutar(cuentaId: cuentaId, metodopagoId: metodoPagoId);
      listaMetodoPago.removeWhere((element) => element.metodoPagoId == metodoPagoId);

      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar el metodo de pago: ${e.toString()}');
      notifyListeners();
    }
  }

  Future<void> changePrimario({
    required String cuentaId,
    required MetodoPago data,
    required MetodoPago? dataAntigua,
  }) async {
    if (dataAntigua != null && dataAntigua == data) return;

    try {
      await changeMetodoPagoPrimario.ejecutar(cuentaId: cuentaId, metodoPago: data);
    } catch (e) {
      debugPrint('Error al cambiar el metodo de pago primario: ${e.toString()}');
    }
  }
}
