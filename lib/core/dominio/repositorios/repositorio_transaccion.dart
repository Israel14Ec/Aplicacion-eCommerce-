import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';

abstract class RepositorioTransaccion {
  Future<List<Transaccion>> getCuentaTransaccion({
    required String cuentaId,
  });

  Future<List<Transaccion>> getTodasTransacciones();

  Future<Transaccion?> getTransaccion({required String transaccionId});

  Future<void> acceptarTransaccion({required Transaccion data});

  Future<void> changeEstadoTransaccion({
    required String transaccionId,
    required int estado,
  });

  Future<void> addReview({required String transaccionId, required Review data});
}
