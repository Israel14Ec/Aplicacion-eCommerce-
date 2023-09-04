import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_transaccion.dart';

class AddReview {
  final RepositorioTransaccion _repositorio;

  AddReview(this._repositorio);

  Future<void> ejecutar({required String transaccionId, required Review data}) async {
    return await _repositorio.addReview(
      transaccionId: transaccionId,
      data: data,
    );
  }
}
