import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/app/constantes/coleccion_nombre.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/core/dominio/casosdeuso/auten/login_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/auten/logout_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/auten/registrar_cuenta.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProveedorAuten with ChangeNotifier {
  // Casos de uso
  final LoginCuenta loginCuenta;
  final RegistrarCuenta registrarCuenta;
  final LogoutCuenta logoutCuenta;

  ProveedorAuten({required this.loginCuenta, required this.registrarCuenta, required this.logoutCuenta}) {
    isLoggedIn();
  }

  // Estado de carga
  bool _isCargando = false;
  bool get isCargando => _isCargando;
  bool _checkUsuario = true;
  bool get checkUsuario => _checkUsuario;

  // Estado de login del usuario
  bool _isUsuarioLoggedIn = false;
  bool get isUsuarioLoggedIn => _isUsuarioLoggedIn;

  // Verificar rol
  bool _isRolValido = true;
  bool get isRolValido => _isRolValido;

  // Verifica el estado de login del usuario
  isLoggedIn() async {
    _checkUsuario = true;
    FirebaseAuth authInstance = FirebaseAuth.instance;

    // Si el usuario actual no es null el usuario ya se logeo
    if (authInstance.currentUser != null) {
      var data = await FirebaseFirestore.instance
          .collection(ColeccionNombre.kCUENTA)
          .doc(authInstance.currentUser!.uid)
          .get();

      Cuenta cuenta = Cuenta.fromJson(data.data()!);

      // Verifica si el usuario tiene permiso para entrar y si no esta baneado
      if (cuenta.rol == FlavorConfig.instancia.flavor.rolValor && !cuenta.banEstado) {
        _isUsuarioLoggedIn = true;
        _isRolValido = true;
      } else {
        authInstance.signOut();
        _isRolValido = false;
        _isUsuarioLoggedIn = false;
      }
    } else {
      _isUsuarioLoggedIn = false;
    }

    _checkUsuario = false;
    notifyListeners();
  }

  // Metodo del login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();

      await loginCuenta.ejecutar(
        email: email,
        password: password,
      );

      _isCargando = false;
      await isLoggedIn();
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al ingresar: ${e.toString()}');
      rethrow;
    }
  }

  // Register Method
  Future<void> registro({
    required String emailAddress,
    required String password,
    required String nombre,
    required String numeroTelefonico,
  }) async {
    try {
      _isCargando = true;
      notifyListeners();

      await registrarCuenta.ejecutar(
        email: emailAddress,
        password: password,
        nombre: nombre,
        numeroTelefonico: numeroTelefonico,
        rol: FlavorConfig.instancia.flavor.rolValor,
      );

      _isCargando = false;
      isLoggedIn();
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al registrarse: ${e.toString()}');
      rethrow;
    }
  }

  // Metodo de logout
  logout() async {
    try {
      await logoutCuenta.ejecutar();

      isLoggedIn();
    } catch (e) {
      debugPrint('Error al cerrar sesión: ${e.toString()}');
      rethrow;
    }
  }

  // Metodo para resetear el password
  resetPassword({required String email}) async {
    try {
      _isCargando = true;
      notifyListeners();

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al resetear el password: ${e.toString()}');
      rethrow;
    }
  }
}
