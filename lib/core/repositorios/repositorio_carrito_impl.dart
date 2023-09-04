import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/app/constantes/coleccion_nombre.dart';
import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/repositorios/repositorio__carrito.dart';

class RepositorioCarritoImpl implements RepositorioCarrito {
  final CollectionReference collectionReference;

  RepositorioCarritoImpl({required this.collectionReference});

  @override
  Future<void> addCarritoCuenta({required String cuentaId, required Carrito data}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kCARRITO).doc(data.carritoId).set(data.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteCarritoCuenta({required String cuentaId, required String carritoId}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kCARRITO).doc(carritoId).delete();
  }

  @override
  Future<List<Carrito>> getCarritoCuenta({required String cuentaId}) async {
    var data = await collectionReference.doc(cuentaId).collection(ColeccionNombre.kCARRITO).get();

    List<Carrito> temp = [];

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => Carrito.fromJson(e.data())));
    }

    return temp;
  }

  @override
  Future<void> updateCarritoCuenta({required String cuentaId, required Carrito data}) async {
    await collectionReference.doc(cuentaId).collection(ColeccionNombre.kCARRITO).doc(data.carritoId).update(data.toJson());
  }
}
