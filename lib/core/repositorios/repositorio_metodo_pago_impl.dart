import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/app/constantes/coleccion_nombre.dart';
import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_metodo_pago.dart';

class RepositorioMetodoPagoImpl implements RepositorioMetodoPago {
  final CollectionReference collectionReference;
  RepositorioMetodoPagoImpl({required this.collectionReference});

  @override
  Future<void> addMetodoPago({required String cuentaId, required MetodoPago data}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kPAYMENTMETHOD).doc(data.metodoPagoId).set(data.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteMetodoPago({required String cuentaId, required String metodoPagoId}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kPAYMENTMETHOD).doc(metodoPagoId).delete();
  }

  @override
  Future<List<MetodoPago>> getMetodoPagoCuenta({required String cuentaId}) async {
    var data = await collectionReference.doc(cuentaId).collection(ColeccionNombre.kPAYMENTMETHOD).get();

    List<MetodoPago> temp = [];

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => MetodoPago.fromJson(e.data())));
    }

    return temp;
  }

  @override
  Future<void> updateMetodoPago({required String cuentaId, required MetodoPago data}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kPAYMENTMETHOD).doc(data.metodoPagoId).update(data.toJson());
  }

  @override
  Future<void> changeMetodoPagoPrimario({required String cuentaId, required MetodoPago metodoPago}) async {
    await collectionReference.doc(cuentaId).update({
      'Metodo de pago principal': metodoPago.toJson(),
    });
  }
}
