import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/form_review_producto.dart';
import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/app/proveedores/proveedor_transaccion.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotonAccionTransaccion extends StatelessWidget {
  final int estadoTransaccion;
  final Transaccion data;
  const BotonAccionTransaccion({super.key, required this.estadoTransaccion, required this.data});

  @override
  Widget build(BuildContext context) {
    void Function()? onPressed;
    String labelText = '';
    EstadoTransaccion status = EstadoTransaccion.values.where((elemento) => elemento.valor == estadoTransaccion).first;

    switch (status) {
      case EstadoTransaccion.procesado:
        labelText = 'Procesado';
        break;
      case EstadoTransaccion.enviado:
        labelText = 'Enviado';
        break;
      case EstadoTransaccion.entregado:
        labelText = 'Entregado';
        onPressed = () {
          context.read<ProveedorTransaccion>().aceptar();
        };
        break;
      case EstadoTransaccion.recibido:
        labelText = 'Añadir Review';
        onPressed = () async {
          List<Review> dataReview = [];

          Cuenta usuarioActual = context.read<ProveedorCuenta>().cuenta;

          dataReview.addAll(
            data.productoComprado.map(
              (e) => Review(
                reviewId: ''.generateUID(),
                productoId: e.productoId,
                producto: e.producto!,
                cuentaId: data.cuentaId,
                estrellas: 0,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                nombreReviewer: usuarioActual.nombre,
              ),
            ),
          );

          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...dataReview.map(
                          (review) => FormReviewProducto(
                            data: review,
                            onTapStar: (estrella) {
                              setState(() {
                                review.estrellas = estrella;
                              });
                            },
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Consumer<ProveedorTransaccion>(
                            builder: (context, valor, child) {
                              if (valor.isCargando) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ElevatedButton(
                                onPressed: dataReview.every((elemento) => elemento.estrellas > 0)
                                    ? () async {
                                        await valor
                                            .subirReview(
                                              transaccionId: data.transaccionId,
                                              data: dataReview,
                                            )
                                            .whenComplete(
                                              () => Navigator.of(context).pop(),
                                            );
                                      }
                                    : null,
                                child: const Text('Añadir Review'),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              );
            },
          );
        };
        break;
      case EstadoTransaccion.rechazado:
        labelText = 'Rechazado';
        break;
      case EstadoTransaccion.calificado:
        labelText = 'Calificado';
        break;
      default:
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
      child: Consumer<ProveedorTransaccion>(
        builder: (context, valor, child) {
          if (valor.isCargando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ElevatedButton(
            onPressed: onPressed,
            child: Text(labelText),
          );
        },
      ),
    );
  }
}
