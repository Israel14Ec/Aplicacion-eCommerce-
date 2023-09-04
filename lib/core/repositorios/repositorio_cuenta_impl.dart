import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_cuenta.dart';

class RepositorioCuentaImpl implements RepositorioCuenta {
  final CollectionReference collectionReference;

  RepositorioCuentaImpl({required this.collectionReference});

  @override
  Future<void> banCuenta({required String cuentaId, required bool ban}) async {
    await collectionReference.doc(cuentaId).update({
      'ban_estado': ban,
    });
  }

  @override
  Future<Cuenta?> getPerfilCuenta({required String cuentaId}) async {
    var doc = await collectionReference.doc(cuentaId).get();

    Cuenta? temp;

    if (doc.exists) {
      temp = Cuenta.fromJson(doc.data() as Map<String, dynamic>);
    }

    return temp;
  }

  @override
  Future<List<Cuenta>> getTodasCuentas() async {
    Query query = collectionReference;
    List<Cuenta> temp = [];

    var data = await query.where('rol', isEqualTo: Flavor.usuario.rolValor).get();

    if (data.docs.isNotEmpty) {
      temp.addAll(data.docs.map((e) => Cuenta.fromJson(e.data() as Map<String, dynamic>)));
    }

    return temp;
  }

  @override
  Future<void> updateCuenta({required String cuentaId, required Map<String, dynamic> data}) async {
    await collectionReference.doc(cuentaId).update(data);
  }
}
