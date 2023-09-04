import 'package:edreams/app/paginas/auten/login/pagina_login.dart';
import 'package:edreams/app/paginas/auten/olvidar_password/pagina_olvidar_password.dart';
import 'package:edreams/app/paginas/auten/registrar/pagina_registrar.dart';
import 'package:edreams/app/paginas/checkout/pagina_checkout.dart';
import 'package:edreams/app/paginas/direccion/add_direccion/pagina_add_direccion.dart';
import 'package:edreams/app/paginas/direccion/edit_direccion/pagina_edit_direccion.dart';
import 'package:edreams/app/paginas/direccion/manejo_direccion/pagina_manejo_direccion.dart';
import 'package:edreams/app/paginas/metodo_pago/add_metodo_pago/pagina_add_metodo_pago.dart';
import 'package:edreams/app/paginas/metodo_pago/edit_metodo_pago/pagina_edit_metodo_pago.dart';
import 'package:edreams/app/paginas/metodo_pago/manejo_metodo_pago/pagina_manejo_metodo_pago.dart';
import 'package:edreams/app/paginas/pago/pagina_pago.dart';
import 'package:edreams/app/paginas/producto/add_producto/pagina_add_producto.dart';
import 'package:edreams/app/paginas/producto/detalles_producto/pagina_deetalles_producto.dart';
import 'package:edreams/app/paginas/producto/edit_producto/pagina_edit_producto.dart';
import 'package:edreams/app/paginas/producto/producto_review/pagina_review_producto.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/pagina_detalles_transaccion.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:flutter/material.dart';


class NombreRutas {
  static const String kLogin = '/login';
  static const String kRegistro = '/registro';
  static const String kAddProducto = '/add_producto';
  static const String kDetallesProducto = '/detalles_producto';
  static const String kEditProducto = '/edit_producto';
  static const String kProductoReview = '/producto_review';
  static const String kOlvidarPassword = '/forgot_password';
  static const String kManejoDireccion = '/manejo_direccion';
  static const String kAddDireccion = '/add_direccion';
  static const String kEditDireccion = '/edit_direccion';
  static const String kManejoMetodoPago = '/manejo_metodo_pago';
  static const String kAddMetodoPago = '/add_metodo_pago';
  static const String kEditMetodoPago = '/edit_metodo_pago';
  static const String kCheckout = '/checkout';
  static const String kPago = '/pago';
  static const String kDetallesTransaccion = '/detalles_transaccion';
}

class RutaNavegacion {
  static toLogin({required BuildContext context}) {
    Navigator.of(context).pushNamed(NombreRutas.kLogin);
  }

  static toRegistro({required BuildContext context}) {
    Navigator.of(context).pushNamed(NombreRutas.kRegistro);
  }

  static toAddProducto({required BuildContext context}) {
    Navigator.of(context).pushNamed(NombreRutas.kAddProducto);
  }

  static toDetallesProducto({required BuildContext context, required String productoId}) {
    Navigator.of(context).pushNamed(NombreRutas.kDetallesProducto, arguments: productoId);
  }

  static toEditProducto({required BuildContext context, required Producto producto}) {
    Navigator.of(context).pushNamed(NombreRutas.kEditProducto, arguments: producto);
  }

  static toProductoReview({required BuildContext context, required List<Review> productoReview}) {
    Navigator.of(context).pushNamed(NombreRutas.kProductoReview, arguments: productoReview);
  }

  static toOlvidarPassword({required BuildContext context}) {
    Navigator.of(context).pushNamed(NombreRutas.kOlvidarPassword);
  }

  static Future toManejoDireccion({required BuildContext context, bool returnDireccion = false}) async {
    return await Navigator.of(context).pushNamed(NombreRutas.kManejoDireccion, arguments: returnDireccion);
  }

  static toAddDireccion({required BuildContext context}) {
    Navigator.of(context).pushNamed(NombreRutas.kAddDireccion);
  }

  static toEditDireccion({required BuildContext context, required Direccion direccion}) {
    Navigator.of(context).pushNamed(NombreRutas.kEditDireccion, arguments: direccion);
  }

  static Future toManejoMetodoPago({required BuildContext context, bool returnMetodoPago = false}) async {
    return await Navigator.of(context).pushNamed(NombreRutas.kManejoMetodoPago, arguments: returnMetodoPago);
  }

  static toAddMetodoPago({required BuildContext context}) {
    Navigator.of(context).pushNamed(NombreRutas.kAddMetodoPago);
  }

  static toEditMetodoPago({required BuildContext context, required MetodoPago metodoPago}) {
    Navigator.of(context).pushNamed(NombreRutas.kEditMetodoPago, arguments: metodoPago);
  }

  static toCheckout({required BuildContext context}) {
    Navigator.of(context).pushNamed(NombreRutas.kCheckout);
  }

  static toPago({required BuildContext context}) {
    Navigator.of(context).pushNamed(NombreRutas.kPago);
  }

  static toDetallesTransaccion({required BuildContext context, required String transaccionID}) {
    Navigator.of(context).pushNamed(NombreRutas.kDetallesTransaccion, arguments: transaccionID);
  }
}

final rutas = {
  NombreRutas.kLogin: (_) => const PaginaLogin(),
  NombreRutas.kRegistro: (_) => const PaginaRegistro(),
  NombreRutas.kAddProducto: (_) => const PaginaAddProducto(),
  NombreRutas.kDetallesProducto: (_) => const PaginaDetallesProducto(),
  NombreRutas.kEditProducto: (_) => const PaginaEditProducto(),
  NombreRutas.kProductoReview: (_) => const PaginaReviewProducto(),
  NombreRutas.kOlvidarPassword: (_) => const PaginaOlvidarPassword(),
  NombreRutas.kManejoDireccion: (_) => const PaginaManejoDireccion(),
  NombreRutas.kAddDireccion: (_) => const PaginaAddDireccion(),
  NombreRutas.kEditDireccion: (_) => const PaginaEditDireccion(),
  NombreRutas.kManejoMetodoPago: (_) => const PaginaManejoMetodoPago(),
  NombreRutas.kAddMetodoPago: (_) => const PaginaAddMetodoPago(),
  NombreRutas.kEditMetodoPago: (_) => const PaginaEditMetodosPago(),
  NombreRutas.kCheckout: (_) => const PaginaCheckout(),
  NombreRutas.kPago: (_) => const PaginaPago(),
  NombreRutas.kDetallesTransaccion: (_) => const PaginaDetalleTransaccion(),
};
