import 'package:edreams/core/dominio/casosdeuso/direccion/add_direccion.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/change_direccion_primaria.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/delete_direccion.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/get_direccion_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/update_direccion.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:flutter/material.dart';

class ProveedorDireccion with ChangeNotifier {
  final AddDireccion addDireccion;
  final GetDireccionCuenta getDireccionCuenta;
  final UpdateDireccion updateDireccion;
  final DeleteDireccion deleteDireccion;
  final ChangeDireccionPrimaria changeDireccionPrimaria;

  ProveedorDireccion({
    required this.addDireccion,
    required this.getDireccionCuenta,
    required this.updateDireccion,
    required this.deleteDireccion,
    required this.changeDireccionPrimaria,
  });

  // Estado de carga
  bool _isCargando = true;
  bool get isCargando => _isCargando;

  // Lista de direcciones
  List<Direccion> _listaDireccion = [];
  List<Direccion> get listaDireccion => _listaDireccion;

  Future<void> add({
    required String cuentaId,
    required Direccion data,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();

      await addDireccion.ejecutar(cuentaId: cuentaId, data: data);
      _listaDireccion.add(data);

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al añadir la direccion: ${e.toString()}');
    }
  }

  getAddress({required String cuentaId}) async {
    try {
      _isCargando = true;
      notifyListeners();
      _listaDireccion.clear();

      var respuesta = await getDireccionCuenta.ejecutar(cuentaId: cuentaId);

      if (respuesta.isNotEmpty) {
        _listaDireccion = respuesta;
      }

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al obtener la direccion: ${e.toString()}');
      notifyListeners();
    }
  }

  Future<void> update({
    required String cuentaId,
    required Direccion data,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();

      await updateDireccion.ejecutar(cuentaId: cuentaId, data: data);
      int indice = listaDireccion.indexWhere((elemento) => elemento.direccionId == data.direccionId);
      listaDireccion[indice] = data;

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al actualizar la direccion: ${e.toString()}');
      notifyListeners();
    }
  }

  delete({
    required String cuentaId,
    required String direccionId,
  }) async {
    try {
      await deleteDireccion.ejecutar(cuentaId: cuentaId, direccionId: direccionId);
      listaDireccion.removeWhere((element) => element.direccionId == direccionId);

      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar la direccion: ${e.toString()}');
      notifyListeners();
    }
  }

  Future<void> changePrimaria({
    required String cuentaId,
    required Direccion data,
    required Direccion? dataAntigua,
  }) async {
    if (dataAntigua != null && dataAntigua == data) return;

    try {
      await changeDireccionPrimaria.ejecutar(cuentaId: cuentaId, data: data);
    } catch (e) {
      debugPrint('Change Primary Address Error: ${e.toString()}');
    }
  }
}
