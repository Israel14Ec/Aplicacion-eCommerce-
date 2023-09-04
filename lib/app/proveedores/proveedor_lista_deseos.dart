import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/add_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/delete_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/get_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/get_producto.dart';
import 'package:edreams/core/dominio/entidades/lista_deseos/listadeseos.dart';
import 'package:flutter/cupertino.dart';

class ProveedorListaDeseos with ChangeNotifier {
  final AddListaDeseosCuenta addListaDeseosCuenta;
  final GetListaDeseosCuenta getListaDeseosCuenta;
  final DeleteListaDeseosCuenta deleteListaDeseosCuenta;
  final GetProducto getProducto;

  ProveedorListaDeseos({
    required this.addListaDeseosCuenta,
    required this.getListaDeseosCuenta,
    required this.deleteListaDeseosCuenta,
    required this.getProducto,
  });

  // Estado de carga
  bool _isDataCargada = true;
  bool get isDataCargada => _isDataCargada;
  bool _isCargando = false;
  bool get isCargando => _isCargando;

  // Lista de las listas de deseos (retorico)
  List<ListaDeseos> _listaListaDeseos = [];
  List<ListaDeseos> get listListaDeseos => _listaListaDeseos;

  cargarListaDeseos({
    required String cuentaId,
    String busqueda = '',
    OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo,
  }) async {
    try {
      _isDataCargada = true;
      notifyListeners();
      _listaListaDeseos.clear();

      var respuesta = await getListaDeseosCuenta.ejecutar(
        cuentaId: cuentaId,
        busqueda: busqueda,
      );

      if (respuesta.isNotEmpty) {
        _listaListaDeseos = respuesta;
        await Future.forEach<ListaDeseos>(_listaListaDeseos, (element) async {
          if (element.producto == null) {
            var dataProducto = await getProducto.ejecutar(productoId: element.productoId);
            element.producto = dataProducto;
          }
        });
        ordenarLista(ordenarPorEnum);
        if (busqueda.isNotEmpty) {
          _listaListaDeseos = _listaListaDeseos
              .where((element) => element.producto!.productoNombre.toLowerCase().contains(busqueda.toLowerCase()))
              .toList();
        }
      }

      _isDataCargada = false;
      notifyListeners();
    } catch (e) {
      _isDataCargada = false;
      debugPrint('Error al cargar la lista de deseos: ${e.toString()}');
      notifyListeners();
    }
  }

  add({required String cuentaId, required ListaDeseos data}) async {
    try {
      _isCargando = true;
      notifyListeners();

      await addListaDeseosCuenta.ejecutar(cuentaId: cuentaId, data: data);

      var dataProducto = await getProducto.ejecutar(productoId: data.productoId);
      data.producto = dataProducto;
      listListaDeseos.add(data);

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al añadir a la lista de deseos: ${e.toString()}');
      notifyListeners();
    }
  }

  delete({required String cuentaId, required String listadeseosId}) async {
    try {
      _isCargando = true;
      notifyListeners();

      await deleteListaDeseosCuenta.ejecutar(cuentaId: cuentaId, listadeseosId: listadeseosId);
      listListaDeseos.removeWhere((elemento) => elemento.listadeseosId == listadeseosId);

      _isCargando = false;
      notifyListeners();
    } catch (e) {
      _isCargando = false;
      debugPrint('Error al eliminar la lista de deseos: ${e.toString()}');
      notifyListeners();
    }
  }

  ordenarLista(OrdenarPorEnum data) {
    switch (data) {
      case OrdenarPorEnum.nuevo:
        listListaDeseos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case OrdenarPorEnum.viejo:
        listListaDeseos.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case OrdenarPorEnum.barato:
        listListaDeseos.sort((a, b) => a.producto!.productoPrecio.compareTo(b.producto!.productoPrecio));
        break;
      case OrdenarPorEnum.caro:
        listListaDeseos.sort((a, b) => b.producto!.productoPrecio.compareTo(a.producto!.productoPrecio));
        break;
      default:
        listListaDeseos.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }
  }
}
