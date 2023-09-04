import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/core/dominio/entidades/lista_deseos/listadeseos.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_lista_deseos.dart';

import '../../app/constantes/coleccion_nombre.dart';

class RepositorioListaDeseosImpl implements RepositorioListaDeseos {
  final CollectionReference collectionReference;
  RepositorioListaDeseosImpl({required this.collectionReference});

  @override
  Future<void> addListaDeseosCuenta({required String cuentaId, required ListaDeseos listaDeseos}) async {
    await collectionReference
        .doc(cuentaId)
        .collection(ColeccionNombre.kLISTADESEOS)
        .doc(listaDeseos.listadeseosId)
        .set(listaDeseos.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteListaDeseosCuenta({required String cuentaId, required String listadeseosId}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kLISTADESEOS).doc(listadeseosId).delete();
  }

  @override
  Future<List<ListaDeseos>> getListaDeseosCuenta({
    required String cuentaId,
    String busqueda = '',
    String ordenarPor = 'created_at',
    bool descendente = true,
  }) async {
    Query query = collectionReference
        .doc(cuentaId)
        .collection(ColeccionNombre.kLISTADESEOS)
        .orderBy(ordenarPor, descending: descendente);
    List<ListaDeseos> temp = [];

    var data = await query.get();

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => ListaDeseos.fromJson(e.data() as Map<String, dynamic>)));
    }

    return temp;
  }
}
