import 'package:edreams/app/widgets/carrito/contador_cantidad_carrito.dart';
import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class ContenedorCarrito extends StatelessWidget {
  final Carrito objeto;
  final Function() onTapAdd;
  final Function() onTapRemove;
  const ContenedorCarrito({Key? key, required this.objeto, required this.onTapAdd, required this.onTapRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        RutaNavegacion.toDetallesProducto(context: context, productoId: objeto.productoId);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 90,
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                objeto.producto!.productoImagen.first,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, cargandoProceso) {
                  if (cargandoProceso == null) return child;

                  return Center(
                    child: CircularProgressIndicator(
                      value: cargandoProceso.expectedTotalBytes != null
                          ? cargandoProceso.cumulativeBytesLoaded / cargandoProceso.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      objeto.producto!.productoNombre,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          objeto.producto!.productoPrecio.toCurrency(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        ContadorCantidadCarrito(
                          onTapAdd: onTapAdd,
                          onTapRemove: onTapRemove,
                          cantidad: objeto.cantidad,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
