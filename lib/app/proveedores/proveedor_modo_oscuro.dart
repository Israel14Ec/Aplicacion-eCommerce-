import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProveedorModoOscuro with ChangeNotifier {
  bool _isModoOscuro = false;
  bool get isModoOscuro => _isModoOscuro;

  bool _isCargando = true;
  bool get isCargando => _isCargando;

  // Obtener el valor del modo oscuro
  getModoOscuro() async {
    try {
      _isCargando = true;

      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('is_modo_oscuro')) {
        _isModoOscuro = prefs.getBool('is_modo_oscuro') ?? false;
      } else {
        _isModoOscuro = false;
        await prefs.setBool('is_modo_oscuro', _isModoOscuro);
      }

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error al obtener el modo oscuro: ${e.toString()}');
    }
  }

  // Establecer el valor del modo oscuro
  setDarkMode(bool valor) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      _isModoOscuro = valor;
      prefs.setBool('is_modo_oscuro', valor);

      notifyListeners();
    } catch (e) {
      debugPrint('Error al establecer el modo oscuro: ${e.toString()}');
    }
  }
}
