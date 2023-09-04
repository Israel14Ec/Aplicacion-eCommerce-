import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_direccion.dart';
import '../../app/constantes/coleccion_nombre.dart';

class RepositorioDireccionImpl implements RepositorioDireccion {
  final CollectionReference collectionReference;

  RepositorioDireccionImpl({required this.collectionReference});

  @override
  Future<void> addDireccion({required String cuentaId, required Direccion data}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kDIRECCION).doc(data.direccionId).set(data.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteDireccion({required String cuentaId, required String direccionId}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kDIRECCION).doc(direccionId).delete();
  }

  @override
  Future<List<Direccion>> getDireccionCuenta({required String cuentaId}) async {
    var data = await collectionReference.doc(cuentaId).collection(ColeccionNombre.kDIRECCION).get();

    List<Direccion> temp = [];

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => Direccion.fromJson(e.data())));
    }

    return temp;
  }

  @override
  Future<void> updateDireccion({required String cuentaId, required Direccion data}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kDIRECCION).doc(data.direccionId).update(data.toJson());
  }

  @override
  Future<void> changeDireccionPrimaria({required String cuentaId, required Direccion direccion}) async {
    await collectionReference.doc(cuentaId).update({
      'direccion_principal': direccion.toJson(),
    });
  }
}
