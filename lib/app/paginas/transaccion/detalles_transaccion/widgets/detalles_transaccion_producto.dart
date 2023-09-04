import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class DetallesTransaccionProducto extends StatelessWidget {
  final Carrito objeto;
  const DetallesTransaccionProducto({Key? key, required this.objeto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        RutaNavegacion.toDetallesProducto(context: context, productoId: objeto.productoId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                loadingBuilder: (_, child, progresoCarga) {
                  if (progresoCarga == null) return child;

                  return Center(
                    child: CircularProgressIndicator(
                      value: progresoCarga.expectedTotalBytes != null
                          ? progresoCarga.cumulativeBytesLoaded / progresoCarga.expectedTotalBytes!
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    objeto.producto!.productoNombre,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    objeto.producto!.productoPrecio.toCurrency(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Cantidad: ${objeto.cantidad.toNumericFormat()}',
                    style: Theme.of(context).textTheme.bodyMedium,
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
