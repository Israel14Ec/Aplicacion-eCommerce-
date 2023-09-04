import 'dart:typed_data';

import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/ban_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/get_perfil_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/get_todas_cuentas.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/update_account.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/verificaciones/comprimir_imagen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProveedorCuenta with ChangeNotifier {
  final GetPerfilCuenta getPerfilCuenta;
  final GetTodasCuentas getTodasCuentas;
  final UpdateCuenta updateCuenta;
  final BanCuenta banCuenta;

  ProveedorCuenta({
    required this.getPerfilCuenta,
    required this.getTodasCuentas,
    required this.updateCuenta,
    required this.banCuenta,
  });

  // Estado de carga
  bool _isPerfilCargado = true;
  bool get isPerfilCargado => _isPerfilCargado;
  bool _isListaCuentasCargada = true;
  bool get isListaCuentasCargada => _isListaCuentasCargada;
  bool _isCargando = false;
  bool get isCargando => _isCargando;

  // Cuenta
  late Cuenta _cuenta;
  Cuenta get cuenta => _cuenta;

  // Lista de cuentas
  List<Cuenta> _listaCuenta = [];
  List<Cuenta> get listaCuenta => _listaCuenta;

  getPerfil() async {
    try {
      _isPerfilCargado = true;
      notifyListeners();

      String cuentaId = FirebaseAuth.instance.currentUser!.uid;
      var respuesta = await getPerfilCuenta.ejecutar(cuentaId: cuentaId);

      if (respuesta != null) {
        _cuenta = respuesta;
      }

      _isPerfilCargado = false;
      notifyListeners();
    } catch (e) {
      _isPerfilCargado = false;
      debugPrint('Error al obtener el perfil: ${e.toString()}');
      notifyListeners();
    }
  }

  getListaCuenta({
    String busqueda = '',
    OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo,
  }) async {
    try {
      _isListaCuentasCargada = true;
      notifyListeners();
      _listaCuenta.clear();

      var respuesta = await getTodasCuentas.ejecutar();

      if (respuesta.isNotEmpty) {
        _listaCuenta = respuesta;
        ordenarLista(ordenarPorEnum);
        if (busqueda.isNotEmpty) {
          _listaCuenta =
              _listaCuenta.where((elemento) => elemento.nombre.toLowerCase().contains(busqueda.toLowerCase())).toList();
        }
      }

      _isListaCuentasCargada = false;
      notifyListeners();
    } catch (e) {
      _isListaCuentasCargada = false;
      debugPrint('Load List Account Error: ${e.toString()}');
      notifyListeners();
    }
  }

  update({required Map<String, dynamic> data}) async {
    try {
      _isCargando = true;
      notifyListeners();

      await updateCuenta.ejecutar(cuentaId: cuenta.cuentaId, data: data);

      _isCargando = false;
      notifyListeners();

      getPerfil();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al actualizar la cuenta: ${e.toString()}');
      notifyListeners();
    }
  }

  ban({required String cuentaId, required bool ban}) async {
    try {
      await banCuenta.ejecutar(cuentaId: cuentaId, ban: ban);
      getListaCuenta();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al banear la cuenta: ${e.toString()}');
      notifyListeners();
    }
  }

  updateFotoPerfil(XFile image) async {
    try {
      _isCargando = true;
      notifyListeners();

      Uint8List data = await image.readAsBytes();

      data = await ComprimirImagen.empezarCompresion(data);

      Reference ref = FirebaseStorage.instance.ref().child('Foto Perfil/${cuenta.nombre}/${image.name}');

      // Guarda la imagen en la base de datos fire storage
      final dataImagen = await ref.putData(data);

      // Obtener el url de la imagen en el storage
      String imagenUrl = await dataImagen.ref.getDownloadURL();

      await updateCuenta.ejecutar(cuentaId: cuenta.cuentaId, data: {
        'url_foto_perfil': imagenUrl,
      });

      _isCargando = false;
      notifyListeners();

      getPerfil();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al actualizar la foto de perfil: ${e.toString()}');
      notifyListeners();
    }
  }

  ordenarLista(OrdenarPorEnum data) {
    switch (data) {
      case OrdenarPorEnum.nuevo:
        listaCuenta.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case OrdenarPorEnum.viejo:
        listaCuenta.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      default:
        listaCuenta.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }
  }

  
  // Función para guardar la foto de perfil en Firestore
Future<void> guardarFotoPerfil(String imageData) async {
  try {
    _isCargando = true;
    notifyListeners();

    Reference ref = FirebaseStorage.instance.ref().child('Foto Perfil/${cuenta.nombre}/perfil.jpg');

    // Guardar la imagen en el Firebase Storage
    final dataImagen = await ref.putString(imageData, format: PutStringFormat.dataUrl);

    // Obtener el URL de la imagen en el Firebase Storage
    String imageUrl = await dataImagen.ref.getDownloadURL();

    await updateCuenta.ejecutar(cuentaId: cuenta.cuentaId, data: {
      'url_foto_perfil': imageUrl,
    });

    _isCargando = false;
    notifyListeners();

    getPerfil();
  } catch (e) {
    _isCargando = false;
    debugPrint('Error al actualizar la foto de perfil: ${e.toString()}');
    notifyListeners();
  }
}

}

