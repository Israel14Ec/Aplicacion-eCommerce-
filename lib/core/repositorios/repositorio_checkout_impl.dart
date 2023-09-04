import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_checkout.dart';
import 'package:edreams/verificaciones/extension.dart';

class RepositorioCheckoutImpl implements RepositorioCheckout {
  final firestore.CollectionReference collectionReference;
  RepositorioCheckoutImpl({required this.collectionReference});

  @override
  Future<void> pagar({required Transaccion data}) async {
    await collectionReference.doc(data.transaccionId).set(data.toJson(), firestore.SetOptions(merge: true));
  }

  @override
  Transaccion iniciarCheckout({required List<Carrito> carrito, required Cuenta cuenta}) {
    double subTotal = 0;
    for (var elemento in carrito) {
      subTotal += elemento.producto!.productoPrecio * elemento.cantidad;
    }

    // TODO: Cambiar los valores de IVA
    double iva = 0.5;

    // TODO: Cambiar los valores de costo de envio
    double costeEnvio = 4;

    Transaccion temp = Transaccion(
      transaccionId: ''.generateUID(),
      cuentaId: cuenta.cuentaId,
      productoComprado: carrito,
      subTotal: subTotal,
      estadoTransaccion: EstadoTransaccion.procesado.valor,
      precioTotal: subTotal,
      iva: iva,
      costeEnvio: costeEnvio,
    );

    return temp;
  }
}
