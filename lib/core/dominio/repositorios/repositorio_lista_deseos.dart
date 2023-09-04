import 'package:edreams/core/dominio/entidades/lista_deseos/listadeseos.dart';

abstract class RepositorioListaDeseos {
  Future<List<ListaDeseos>> getListaDeseosCuenta({
    required String cuentaId,
    String busqueda = '',
    String ordenarPor = 'created_at',
    bool descendente = true,
  });

  Future<void> addListaDeseosCuenta({required String cuentaId, required ListaDeseos listaDeseos});

  Future<void> deleteListaDeseosCuenta({required String cuentaId, required String listadeseosId});
}
