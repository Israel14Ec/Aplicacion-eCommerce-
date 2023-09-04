import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_auten.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositorioAutenImpl implements RepositorioAuten {
  final FirebaseAuth auth;
  final CollectionReference collectionReference;
  RepositorioAutenImpl({required this.auth, required this.collectionReference});

  @override
  Future<void> login({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> registro({required String email, required String password, required String nombre, required String numeroTelefonico, required int rol}) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);

    Cuenta data = Cuenta(
      cuentaId: auth.currentUser!.uid,
      nombre: nombre,
      email: email,
      numeroTelefonico: numeroTelefonico,
      rol: rol,
      banEstado: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      urlFotoPerfil: '',
    );

    await collectionReference.doc(data.cuentaId).set(data.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
