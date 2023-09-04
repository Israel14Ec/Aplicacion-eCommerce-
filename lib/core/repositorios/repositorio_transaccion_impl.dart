import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:edreams/app/constantes/coleccion_nombre.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_transaccion.dart';

class RepositorioTransaccionImpl implements RepositorioTransaccion {
  final firestore.CollectionReference collectionReference;

  RepositorioTransaccionImpl({required this.collectionReference});

  @override
  Future<void> acceptarTransaccion({required Transaccion data}) async {
    await collectionReference.doc(data.transaccionId).update({
      'estado_transaccion': EstadoTransaccion.entregado.valor,
    });
  }

  @override
  Future<void> addReview({required String transaccionId, required Review data}) async {
    await firestore.FirebaseFirestore.instance
        .collection(ColeccionNombre.kPRODUCTO)
        .doc(data.productoId)
        .collection(ColeccionNombre.kREVIEW)
        .doc(data.reviewId)
        .set(data.toJson(), firestore.SetOptions(merge: true));

    // Calcular Rating
    var dataReview = await firestore.FirebaseFirestore.instance
        .collection(ColeccionNombre.kPRODUCTO)
        .doc(data.productoId)
        .collection(ColeccionNombre.kREVIEW)
        .get();
    List<Review> tempReview = [];

    if (dataReview.docs.isNotEmpty) {
      tempReview.addAll(
        dataReview.docs.map(
          (e) => Review.fromJson(e.data()),
        ),
      );
    }

    double totalEstrellas = 0;
    double rating = 0;
    int totalReviews = 0;

    totalReviews = tempReview.length;

    for (var element in tempReview) {
      totalEstrellas += element.estrellas;
    }

    rating = totalEstrellas / totalReviews;

    await firestore.FirebaseFirestore.instance.collection(ColeccionNombre.kPRODUCTO).doc(data.productoId).update({
      'reviews_totales': totalReviews,
      'rating': rating,
    });
  }

  @override
  Future<void> changeEstadoTransaccion({required String transaccionId, required int estado}) async {
    await collectionReference.doc(transaccionId).update({
      'estado_transaccion': estado,
    });
  }

  @override
  Future<List<Transaccion>> getCuentaTransaccion({
    required String cuentaId,
  }) async {
    firestore.Query query = collectionReference;
    List<Transaccion> temp = [];

    var data = await query.where('cuenta_id', isEqualTo: cuentaId).get();

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => Transaccion.fromJson(e.data() as Map<String, dynamic>)));
    }

    return temp;
  }

  @override
  Future<List<Transaccion>> getTodasTransacciones() async {
    firestore.Query query = collectionReference;
    List<Transaccion> temp = [];

    var data = await query.get();

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => Transaccion.fromJson(e.data() as Map<String, dynamic>)));
    }

    return temp;
  }

  @override
  Future<Transaccion?> getTransaccion({required String transaccionId}) async {
    var data = await collectionReference.doc(transaccionId).get();

    if (data.exists) {
      return Transaccion.fromJson(data.data() as Map<String, dynamic>);
    }

    return null;
  }
}
