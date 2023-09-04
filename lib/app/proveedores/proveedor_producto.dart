import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/add_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/delete_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/get_lista_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/get_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/get_producto_review.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/update_producto.dart';
import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:flutter/material.dart';

class ProveedorProducto with ChangeNotifier {
  // Casos de uso
  final GetListaProducto getListaProducto;
  final GetProducto getProducto;
  final GetProductoReview getProductoReview;
  final AddProducto addProducto;
  final UpdateProducto updateProducto;
  final DeleteProducto deleteProducto;

  ProveedorProducto({
    required this.getListaProducto,
    required this.getProducto,
    required this.getProductoReview,
    required this.addProducto,
    required this.updateProducto,
    required this.deleteProducto,
  });

  // Estado de carga
  bool _isCargando = true;
  bool get isCargando => _isCargando;
  set setCargando(bool valor) {
    _isCargando = valor;
    notifyListeners();
  }

  // Lista de productos
  List<Producto> _listaProducto = [];
  List<Producto> get listaProducto => _listaProducto;

  // Lista de reviews de productos
  List<Review> _listaProductoReview = [];
  List<Review> get listaProductoReview => _listaProductoReview;

  // Detalles del producto
  Producto? _detalleProducto;
  Producto? get detalleProducto => _detalleProducto;

  Future<void> cargarListaProducto({
    String busqueda = '',
    OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo,
  }) async {
    _isCargando = true;
    notifyListeners();
    _listaProducto.clear();

    try {
      var respuesta = await getListaProducto.ejecutar(
        busqueda: busqueda,
      );

      if (respuesta.isNotEmpty || busqueda.isNotEmpty) {
        _listaProducto = respuesta;
        ordenarLista(ordenarPorEnum);
      }

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al cargar la lista de productos: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> cargarDetallesProducto({required String productoId}) async {
    _isCargando = true;
    notifyListeners();

    try {
      var respuestaDetalles = await getProducto.ejecutar(productoId: productoId);
      var respuestaReviews = await getProductoReview.ejecutar(productoId: productoId);

      if (respuestaDetalles != null) {
        _detalleProducto = respuestaDetalles;
      }

      if (respuestaReviews.isNotEmpty) {
        _listaProductoReview = respuestaReviews;
      }

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al cargar detalles del producto: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> add({required Producto data}) async {
    try {
      await addProducto.ejecutar(data: data);
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al añadir el producto: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> update({required Producto data}) async {
    try {
      await updateProducto.ejecutar(data: data);
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al actualizar el producto: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> delete({required String productoId}) async {
    try {
      _isCargando = true;
      notifyListeners();

      await deleteProducto.ejecutar(productoId: productoId);

      _isCargando = false;
    } catch (e) {
      _isCargando = false;
      notifyListeners();
      debugPrint('Error al eliminar el producto: ${e.toString()}');
      rethrow;
    }
  }

  ordenarLista(OrdenarPorEnum data) {
    switch (data) {
      case OrdenarPorEnum.nuevo:
        listaProducto.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case OrdenarPorEnum.viejo:
        listaProducto.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case OrdenarPorEnum.barato:
        listaProducto.sort((a, b) => a.productoPrecio.compareTo(b.productoPrecio));
        break;
      case OrdenarPorEnum.caro:
        listaProducto.sort((a, b) => b.productoPrecio.compareTo(a.productoPrecio));
        break;
      default:
        listaProducto.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }
  }
}
